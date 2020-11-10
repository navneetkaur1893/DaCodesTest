//
//  URLBuilder.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

class URLBuilder {
    static func getMoviesListURL(pageId: Int) -> String {
        let apiKey = Constants.ApiKey
        let language = Constants.Language
        return URLPath.BaseURLString + "now_playing?api_key=" + apiKey + "&language=\(language)&page=\(pageId)"
    }
    
    static func getMovieDetailsURL(movieId: Int) -> String {
        let apiKey = Constants.ApiKey
        let language = Constants.Language
        return URLPath.BaseURLString + "\(movieId)" + "?api_key=" + apiKey + "&language=\(language)"
    }
    
    static func getImageURL(imageURL: String) -> String {
        return URLPath.ImageBaseURLString + imageURL
    }
}
