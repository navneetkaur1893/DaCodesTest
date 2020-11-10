//
//  MoviesListViewModelTests.swift
//  DaCodesTestTests
//
//  Created by Navneet Kaur on 11/9/20.
//

import XCTest
@testable import DaCodesTest

class MoviesListViewModelTests: XCTestCase {

    // MARK: Properties
    var viewModel: MoviesListViewModel = MoviesListViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel.fetchMoviewList()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        XCTAssertNotNil(viewModel.moviesList)
        XCTAssertEqual(viewModel.moviesList?.results?.count, 20)
        XCTAssertEqual(viewModel.moviesList?.page, 1)
        XCTAssertEqual(viewModel.moviesList?.totalResults, 1560)
        XCTAssertEqual(viewModel.moviesList?.dates?.maximum, "2020-11-07")
        XCTAssertEqual(viewModel.moviesList?.dates?.minimum, "2020-09-20")
        XCTAssertEqual(viewModel.moviesList?.totalPages, 78)
    }

    func testTableDataSource() {
        let expectedSectionsCount = 1
        let expectedRowsCount = 20
        let movieAtIndex = IndexPath(row: 0, section: 1)
        
        XCTAssertEqual(viewModel.getNumberOfSections(), expectedSectionsCount)
        XCTAssertEqual(viewModel.getNumberOfRows(), expectedRowsCount)
        
        let movie = viewModel.getMovie(at: movieAtIndex)
        XCTAssertEqual(movie?.id, 635302)
        XCTAssertEqual(movie?.title, "Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train")
        XCTAssertEqual(movie?.releaseDate, "2020-10-16")
        XCTAssertEqual(movie?.voteAverage, 6.3)
        XCTAssertEqual(movie?.posterPath, "/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg")
        XCTAssertEqual(CommonLogic.changeDateFormat(into: .d_MMM_YYYY, dateString: movie?.releaseDate ?? "-"), "16-Oct-2020")
    }
    
    func testDataModificationMethods() {
        let movieId = 635302
        let movieAtIndex = IndexPath(row: 0, section: 1)
        viewModel.setSelectedMovieId(of: movieAtIndex)
        XCTAssertEqual(viewModel.getSelectedMovieId(), movieId)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
