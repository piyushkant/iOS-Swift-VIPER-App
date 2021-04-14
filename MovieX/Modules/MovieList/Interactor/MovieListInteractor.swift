//
//  MovieListInteractor.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieListInteractor: PresenterToInteractorMovieListProtocol {
    var presenter: InteractorToPresenterMovieListProtocol?

    func fetchMovieList(category: MovieListCategory, page: Int) {
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
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
                    
                    self.presenter?.noticeFetchedSuccess(movieArray: arrayObject)
                }
            } else {
                self.presenter?.noticeFetchFailed()
            }
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
        }
    }
}
