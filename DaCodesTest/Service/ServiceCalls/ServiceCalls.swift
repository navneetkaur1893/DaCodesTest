//
//  ServiceCalls.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

enum DataError: Error {
    case noData
    case errorFound
}

class ServiceCalls: MoviesAPIServiceRepresentable {
    
    var manager = RequestManager()
    static let shared = ServiceCalls()
    
    private init () {}
    
    // Method to get the census data from the server.
    func getMoviesListFromServer(pageId: Int, completion: @escaping (_ result: Movies?, _ error: Error?) -> Void) {
        let urlString = URLBuilder.getMoviesListURL(pageId: pageId)
        manager.get(url: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    // The data is returned in JSON format and needs to be converted into something that swift can work with
                    // we are converting it into a model of decodable type.
                    let responseModel = try JSONDecoder().decode(Movies.self, from: data)
                    completion(responseModel, nil)
                } catch let error as NSError {
                    // Handle error here
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // Method to get the census data from the server.
    func getMovieDetailsFromServer(movieId: Int, completion: @escaping (_ result: MovieDetails?, _ error: Error?) -> Void) {
        let urlString = URLBuilder.getMovieDetailsURL(movieId: movieId)
        manager.get(url: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    // The data is returned in JSON format and needs to be converted into something that swift can work with
                    // we are converting it into a model of decodable type.
                    let responseModel = try JSONDecoder().decode(MovieDetails.self, from: data)
                    completion(responseModel, nil)
                } catch let error as NSError {
                    // Handle error here
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
