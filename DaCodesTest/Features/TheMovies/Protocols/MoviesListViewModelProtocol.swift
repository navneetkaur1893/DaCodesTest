//
//  MoviesListViewModelProtocol.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

protocol MoviesListViewModelProtocol {
    // MARK: Properties
    var pageId: Int{ get set }
    var moviesList: Movies? { get set }
    
    // Callback variables
    var updateState: ((_ state: CollectionState) -> Void)? { get set }
    
    // Methods
    func fetchMoviewList(pageId: Int)
    func checkForNextServiceCall(indexPath: IndexPath)
    
    // MARK: Datasource methods
    func getNumberOfRows() -> Int
    func getMovie(at indexPath: IndexPath) -> MoviesList?
}
