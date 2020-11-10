//
//  MockServiceCalls.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

class MockServiceCalls: MoviesAPIServiceRepresentable {
    
    static let shared = MockServiceCalls()
    private init () {}
    
    // Method to get the movies list data from the local JSON file.
    func getMoviesListFromServer(pageId: Int, completion: @escaping (_ result: Movies?, _ error: Error?) -> Void) {
        let moviesListResponseJson = JSONFile.mockMoviesListResponse
        guard let jsonData = loadJSON(from: moviesListResponseJson) else { return }
        do {
          let moviesListResponse = try JSONDecoder().decode(Movies.self, from: jsonData)
          completion(moviesListResponse, nil)
        } catch {
          completion(nil, error)
        }
    }
    
    // Method to get the movie details data from the local JSON file.
    func getMovieDetailsFromServer(movieId: Int, completion: @escaping (_ result: MovieDetails?, _ error: Error?) -> Void) {
        let moviedetailsResponseJson = JSONFile.mockMovieDetailsResponse
        guard let jsonData = loadJSON(from: moviedetailsResponseJson) else { return }
        do {
          let moviesDetailsResponse = try JSONDecoder().decode(MovieDetails.self, from: jsonData)
          completion(moviesDetailsResponse, nil)
        } catch {
          completion(nil, error)
        }
    }
}

extension MockServiceCalls {
    // MARK: - load JSON from the bundle
    /**
     Fetch details from mock json file.
     - returns: The data.
     */
    private func loadJSON(from filename: String) -> Data? {
      guard let path = Bundle.main.path(forResource: filename, ofType: nil), let data = NSData(contentsOfFile: path) else {
        return nil
      }
      return data as Data
    }
}
