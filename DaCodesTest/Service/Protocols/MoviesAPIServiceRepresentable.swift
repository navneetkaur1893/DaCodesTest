//
//  MoviesAPIServiceRepresentable.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

protocol MoviesAPIServiceRepresentable {
    func getMoviesListFromServer(pageId: Int, completion: @escaping (_ result: Movies?, _ error: Error?) -> Void)
    func getMovieDetailsFromServer(movieId: Int, completion: @escaping (_ result: MovieDetails?, _ error: Error?) -> Void)
}
