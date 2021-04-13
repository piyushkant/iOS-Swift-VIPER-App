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
private let BUDGET = "budget"
private let HOMEPAGE = "homepage"
private let ORIGINAL_LANGUAGE = "original_language"
private let RUNTIME = "runtime"
private let STATUS = "status"
private let REVENUE = "revenue"

class MovieDetail: Mappable {
    internal var id:Int?
    internal var title: String?
    internal var relaseDate: String?
    internal var posterPath: String?
    internal var overview: String?
    internal var adult: Bool?
    internal var budget: Int?
    internal var homepage: String?
    internal var originalLanguage: String?
    internal var runtime: Int?
    internal var status: String?
    internal var revenue: Int?
    
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
        budget <- map[BUDGET]
        homepage <- map[HOMEPAGE]
        originalLanguage <- map[ORIGINAL_LANGUAGE]
        runtime <- map[RUNTIME]
        status <- map[STATUS]
        revenue <- map[REVENUE]
    }
}
