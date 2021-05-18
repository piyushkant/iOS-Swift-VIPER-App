//
//  MovieListInteractor.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

class MovieListInteractor: PresenterToInteractorMovieListProtocol {
    
    var presenter: InteractorToPresenterMovieListProtocol?
    
    let realm = try! Realm()

    func fetchMovieList(category: MovieListCategory, page: Int) {
        if category == .favourite {
            let movieArray = Array(realm.objects(Movie.self))
            self.presenter?.noticeFetchedSuccess(movieArray: movieArray, isModified: false)
        } else {
            var apiKey: String {
                get {
                    return PropertyUtils.getValue(fileName: "Api-Info", key: "api_key")
                }
            }
            
            let parameters: Parameters = [
                "api_key": apiKey,
                "page": page,
                "language": "en-US"
            ]
            
            Alamofire.request(getEndoint(category: category), method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { response in
                
                if(response.response?.statusCode == 200) {
                    if let json = response.result.value as AnyObject? {
                        let arrayResponse = json["results"] as! NSArray
                        let movieArray = Mapper<Movie>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
                        
                        self.presenter?.noticeFetchedSuccess(movieArray: movieArray, isModified: false)
                    }
                } else {
                    self.presenter?.noticeFetchFailed()
                }
            }
        }
    }
    
    func storeMovieToDb(movie: Movie) {
        try! realm.write {
            self.realm.add(movie, update: .modified)
        }
    }
    
    func removeMovieFromDb(movie: Movie) {
        try! realm.write {
            self.realm.delete(movie)
            let movieArray = Array(realm.objects(Movie.self))
            self.presenter?.noticeFetchedSuccess(movieArray: movieArray, isModified: true)
        }
    }
    
    private func getEndoint(category: MovieListCategory) -> URL{
        switch category {
        case .popular:
            return EndPoint.popular.url
        case .topRated:
            return EndPoint.topRated.url
        case .nowPlaying:
            return EndPoint.nowPlaying.url
        case .upcoming:
            return EndPoint.upcoming.url
        case .favourite:
            return EndPoint.popular.url
        }
    }
}
