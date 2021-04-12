//
//  MovieList.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let POSTER_PATH = "poster_path"

class Movie: Mappable {
    internal var id:Int?
    internal var title: String?
    internal var posterPath: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        title <- map[TITLE]
        posterPath <- map[POSTER_PATH]
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        // Two movies are the same if they have the same id
        return lhs.id == rhs.id
    }
}
