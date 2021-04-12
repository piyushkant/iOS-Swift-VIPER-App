//
//  ApiConst.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation

enum EndPoint {
    private static let apiBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/")!
    private static let posterBaseUrl = URL(string: "https://image.tmdb.org/t/p/original")!
    
    case popular
    case topRated
    case nowPlaying
    case upcoming
    case details (id: String)
    case poster(path: String)
    
    var url: URL {
        switch self {
        case .popular:
            return EndPoint.apiBaseUrl.appendingPathComponent("popular")
        case .topRated:
            return EndPoint.apiBaseUrl.appendingPathComponent("top_rated")
        case .nowPlaying:
            return EndPoint.apiBaseUrl.appendingPathComponent("now_playing")
        case .upcoming:
            return EndPoint.apiBaseUrl.appendingPathComponent("upcoming")
        case .details (let id):
            return EndPoint.apiBaseUrl.appendingPathComponent("\(id)/home_timeline.json")
        case .poster (let path):
            return EndPoint.posterBaseUrl.appendingPathComponent(path)
        }
    }
}

