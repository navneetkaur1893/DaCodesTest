//
//  MovieDetailsViewModel.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

class MovieDetailsViewModel {
    
    // MARK: Properties
    var movieId: Int?
    var movieDetails: MovieDetails?
    var titlesArray = ["Duración", "Fecha de estreno", "Calificación", "Géneros", "Descripción"]
    
    // Callback variables
    var updateState: ((_ state: CollectionState) -> Void)?
    
    // MARK: Method calling
    /**
     Method generates the mail and saves to the local db and calls toNextControllerHandler.
     */
    func fetchMovieDetails() {
        guard let movieId = movieId else { return }
        updateState?(.loading)
        APIServiceFactory.moviesAPIService.getMovieDetailsFromServer(movieId: movieId) { [weak self] (details, error) in
            if error != nil {
                self?.updateState?(.error)
            }
            guard let details = details else { return }
            self?.movieDetails = details
            self?.updateState?(.success)
        }
    }
    
    func getGenres() -> String {
        var value: String = ""
        guard let genres = movieDetails?.genres, genres.count > 0 else {
            return "N/A"
        }
        for genre in genres {
            if value.count > 0 {
                value.append(", ")
            }
            value.append(genre.name ?? "")
        }
        return value
    }
    
    func getValue(at indexPath: IndexPath) -> String {
        var value: String = ""
        switch indexPath.row {
        case 0:
            value = movieDetails?.runtime?.description ?? "-"
        case 1:
            let dateString = movieDetails?.releaseDate ?? "-"
            value = CommonLogic.changeDateFormat(into: .dMMMMYYYY, dateString: dateString)
        case 2:
            value = movieDetails?.popularity?.description ?? "-"
        case 3:
            value = getGenres()
        case 4:
            value = movieDetails?.overview?.description ?? "-"
        default: break
        }
        
        return value
    }
    
    // MARK: Delegate & Datasource methods
    ///
    /// - Return: Count of number of sections
    func getNumberOfSections() -> Int {
        return 2
    }
    
    /// This method is to return number of rows
    ///
    /// - Return: Count of number of rows
    func getNumberOfRows(section: Int) -> Int {
        return section == 0 ? 1 : 5
    }
    
    /// This method is to return a title
    ///
    /// - Return:  A title
    func getTitle(at indexPath: IndexPath) -> String {
        return titlesArray[indexPath.row] + ":"
    }
    
    func getHeaderTitle() -> String {
        return movieDetails?.title ?? "N/A"
    }
}
