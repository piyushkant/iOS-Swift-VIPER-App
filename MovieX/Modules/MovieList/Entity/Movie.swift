//
//  MovieList.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class Movie: Object, Mappable {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var relaseDate = ""
    dynamic var posterPath = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map:Map){
        id <- map["id"]
        title <- map["title"]
        relaseDate <- map["release_date"]
        posterPath <- map["poster_path"]
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
