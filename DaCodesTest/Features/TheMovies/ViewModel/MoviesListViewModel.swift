//
//  MoviesListViewModel.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import Foundation

class MoviesListViewModel: MoviesListViewModelProtocol {
    
    // MARK: Properties
    var pageId: Int = 1
    private var selectedMovieId:  Int?
    var moviesList: Movies?
    //let dispatchGroup = DispatchGroup()
    
    // Callback variables
    var updateState: ((_ state: CollectionState) -> Void)?
    
    func fetchMoviewList(pageId: Int = 1) {
        //dispatchGroup.enter()
        updateState?(.loading)
        APIServiceFactory.moviesAPIService.getMoviesListFromServer(pageId: pageId) { [weak self] (movies, error) in
            if error != nil {
                self?.updateState?(.error)
            }
            guard let movies = movies else { return }
            if self?.moviesList == nil || pageId == 1 {
                self?.moviesList = movies
            } else {
                self?.pageId = movies.page ?? 1
                self?.moviesList?.page = movies.page
                if let newRecords = movies.results {
                    self?.moviesList?.results?.append(contentsOf: newRecords)
                }
            }
            
            self?.updateState?(.success)
            //self?.dispatchGroup.leave()
        }
    }
    
    func checkForNextServiceCall(indexPath: IndexPath) {
        if indexPath.row + 1 == moviesList?.results?.count && moviesList?.totalPages ?? 0 > pageId {
            if let page = moviesList?.page {
                pageId = page + 1
                print("New page id: \(pageId)")
                fetchMoviewList(pageId: pageId)
            }
        }
    }
    
    func setSelectedMovieId(of indexPath: IndexPath) {
        selectedMovieId = moviesList?.results?[indexPath.row].id
    }
    
    func getSelectedMovieId() -> Int? {
        return selectedMovieId
    }
    
    // MARK: Delegate & Datasource methods
    ///
    /// - Return: Count of number of sections
    func getNumberOfSections() -> Int {
        return 1
    }
    
    /// This method is to return number of rows
    ///
    /// - Return: Count of number of rows
    func getNumberOfRows() -> Int {
        return moviesList?.results?.count ?? 0
    }
    
    /// This method is to return an item
    ///
    /// - Return:  A MoviesList
    func getMovie(at indexPath: IndexPath) -> MoviesList? {
        return moviesList?.results?[indexPath.row]
    }
}
