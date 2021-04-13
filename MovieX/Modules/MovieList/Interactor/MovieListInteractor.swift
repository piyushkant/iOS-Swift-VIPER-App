//
//  MovieListInteractor.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieListInteractor: PresenterToInteractorProtocol {
    var allPosterData = [PosterData]()
    var presenter: InteractorToPresenterProtocol?

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
        
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
        
        
        Alamofire.request(EndPoint.popular.url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { response in

            if(response.response?.statusCode == 200) {
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["results"] as! NSArray
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
                    
                    self.presenter?.noticeFetchedSuccess(movieArray: arrayObject)
                    
                    for movie in arrayObject {
                        if let posterPath = movie.posterPath {
                            let request = URLRequest(url: EndPoint.poster(path: posterPath).url)
                                        
                            let task = session.dataTask(with: request) {
                                (data, response, error) -> Void in
                                
                                if let id = movie.id, let data = data {
                                    self.allPosterData.append(PosterData(id: id, data: data))
                                }
                            }
                            task.resume()
                        }
                    }
                }
            } else {
                self.presenter?.noticeFetchFailed()
            }
        }
    }
}
