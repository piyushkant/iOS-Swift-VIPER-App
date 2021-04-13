//
//  MovieDetailInteractor.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieDetailInteractor: PresenterToInteractorMovieDetailProtocol {
    var presenter: InteractorToPresenterMovieDetailProtocol?
    
    func fetchMovieDetail(id: Int) {
        var apiKey: String {
            get {
                return PropertyUtils.getValue(fileName: "Api-Info", key: "api_key")
            }
        }
    
        let parameters: Parameters = [
            "api_key": apiKey,
            "language": "en-US"
        ]
        
        let url = EndPoint.detail(id: id).url
                
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { response in
            if(response.response?.statusCode == 200) {
                print(response)
//                if let json = response.result.value as AnyObject? {
//                    let arrayResponse = json["results"] as! NSArray
//                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
//
//                    self.presenter?.noticeFetchedSuccess(movieArray: arrayObject)
//                }
            } else {
                self.presenter?.noticeFetchFailed()
            }
        }
    }
}
