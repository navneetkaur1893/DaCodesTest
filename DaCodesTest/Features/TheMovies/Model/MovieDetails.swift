//
//  MovieDetails.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

struct MovieDetails: Decodable {
    let posterPath: String?
    let title: String?
    let runtime: Int?
    let releaseDate: String?
    let popularity: Float?
    let genres: [Genres]?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case runtime
        case releaseDate = "release_date"
        case popularity
        case genres
        case overview
    }
}

struct Genres: Decodable {
    let id: Int?
    let name: String?
}
