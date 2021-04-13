//
//  Entity.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let RELEASE_DATE = "release_date"
private let POSTER_PATH = "poster_path"
private let OVERVIEW = "overview"
private let ADULT = "adult"

class MovieDetail: Mappable {
    internal var id:Int?
    internal var title: String?
    internal var relaseDate: String?
    internal var posterPath: String?
    internal var overview: String?
    internal var adult: Bool?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        title <- map[TITLE]
        relaseDate <- map[RELEASE_DATE]
        posterPath <- map[POSTER_PATH]
        overview <- map[OVERVIEW]
        adult <- map[ADULT]
    }
}
