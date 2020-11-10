//
//  MovieDetailsViewModelTests.swift
//  DaCodesTestTests
//
//  Created by Navneet Kaur on 11/9/20.
//

import XCTest
@testable import DaCodesTest

class MovieDetailsViewModelTests: XCTestCase {

    // MARK: Properties
    var viewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    
    override func setUpWithError() throws {
        viewModel.movieId = 635302
        viewModel.fetchMovieDetails()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        XCTAssertNotNil(viewModel.movieDetails)
        XCTAssertEqual(viewModel.movieDetails?.posterPath, "/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg")
        XCTAssertEqual(viewModel.movieDetails?.title, "Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train")
        XCTAssertEqual(viewModel.movieDetails?.runtime, 117)
        XCTAssertEqual(viewModel.movieDetails?.releaseDate, "2020-10-16")
        XCTAssertEqual(viewModel.movieDetails?.popularity, 3778.011)
        XCTAssertEqual(viewModel.movieDetails?.genres?.count, 6)
        XCTAssertEqual(viewModel.movieDetails?.overview, "Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar's head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!")
    }

    func testTableDataSource() {
        let expectedSectionsCount = 2
        let expectedRowsCountInSectionFirst = 1
        let expectedRowsCountInSectionSecond = 5
        
        XCTAssertEqual(viewModel.getNumberOfSections(), expectedSectionsCount)
        XCTAssertEqual(viewModel.getNumberOfRows(section: 0), expectedRowsCountInSectionFirst)
        XCTAssertEqual(viewModel.getNumberOfRows(section: 1), expectedRowsCountInSectionSecond)
        
        // Check for the movie name.
        XCTAssertEqual(viewModel.getHeaderTitle(), "Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train")
        
        // Check titles of the label.
        for row in 0...4 {
            let indexPath = IndexPath(row: row, section: 1)
            let title = viewModel.getTitle(at: indexPath)
            XCTAssertEqual(title, viewModel.titlesArray[row] + ":")
        }
        
        // Check values of the label.
        for row in 0...4 {
            let indexPath = IndexPath(row: row, section: 1)
            let title = viewModel.getValue(at: indexPath)
            let details = viewModel.movieDetails
            switch row {
            case 0:
                XCTAssertEqual(title, "117")
            case 1:
                let dateString = details?.releaseDate ?? "-"
                XCTAssertEqual(CommonLogic.changeDateFormat(into: .dMMMMYYYY, dateString: dateString), "16 October 2020")
            case 2:
                XCTAssertEqual(title, "3778.011")
            case 3:
                XCTAssertEqual(viewModel.getGenres(), "Animation, Action, History, Adventure, Fantasy, Drama")
            case 4:
                XCTAssertEqual(title, "Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar's head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!")
            default: break
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
