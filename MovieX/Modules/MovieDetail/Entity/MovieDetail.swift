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
private let GENRES = "genres"
private let PROD_COMPANIES = "production_companies"
private let PROD_COUNTRIES = "production_countries"
private let VOTE_AVG = "vote_average"
private let VOTE_COUNT = "vote_count"

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
    internal var genres: [Genre]?
    internal var prodCompanies: [ProdCompanies]?
    internal var prodCountries: [ProdCountries]?
    internal var voteAvg: Float?
    internal var voteCount: Int?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
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
        genres <- map[GENRES]
        prodCompanies <- map[PROD_COMPANIES]
        prodCountries <- map[PROD_COUNTRIES]
        voteAvg <- map[VOTE_AVG]
        voteCount <- map[VOTE_COUNT]
    }
}

private let NAME = "name"

class Genre: Mappable {
    internal var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        name <- map[NAME]
    }
}

class ProdCompanies: Mappable {
    internal var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        name <- map[NAME]
    }
}

class ProdCountries: Mappable {
    internal var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        name <- map[NAME]
    }
}
