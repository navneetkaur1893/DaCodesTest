//
//  Constants.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

struct Constants {
    // Constant values
    static let Error = "Error"
    static let Cancel = "Cancel"
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
    static let ApplicationJSON = "application/json"
    static let Language = "en-US"
    static let ApiKey = "634b49e294bd1ff87914e7b9d014daed"
}

struct URLPath {
    static let ImageBaseURLString = "https://image.tmdb.org/t/p/w500"
    static let BaseURLString = "https://api.themoviedb.org/3/movie/"
}

struct Cells {
    static let MoviesListCell = "MoviesListCell"
    static let MoviePosterCell = "MoviePosterCell"
    static let MovieDetailsCell = "MovieDetailsCell"
}

struct SegueId {
    static let movieDetailsVC = "SegueToMovieDetailsVC"
}

struct ScreenTitle {
    static let Peliculas = "Películas"
}

struct Images {
    static let noImage = "noimage"
}

enum DateFormatTypes: String {
    case dMMMMYYYY = "d MMMM yyyy"
    case d_MMM_YYYY = "d-MMM-yyyy"
}

struct JSONFile {
    static let mockMoviesListResponse = "MockMoviesList.json"
    static let mockMovieDetailsResponse = "MockMovieDetails.json"
}
