//
//  MoviewList.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

struct Movies: Decodable {
    var results: [MoviesList]?
    var page: Int?
    let totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

struct Dates:Decodable {
    let maximum: String?
    let minimum: String?
}

struct MoviesList: Decodable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let title: String?
    let voteAverage: Float?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
