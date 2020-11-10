//
//  MoviesListViewControllerUITests.swift
//  DaCodesTestUITests
//
//  Created by Navneet Kaur on 11/9/20.
//

import XCTest

class MoviesListViewControllerUITests: XCTestCase {

    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments.append("isTestMode")
        app.launchArguments.append("NoAnimations")
        continueAfterFailure = false
        app.launch()
    }

    func testMoviesListFlow() {
        let navTitle = app.navigationBars["Películas"]
        XCTAssertTrue(navTitle.exists)
        sleep(1)
    
        let cellFirst = app.collectionViews.cells.element(boundBy: 0)
        let posterImageView = cellFirst.images.element(matching: .any, identifier: "posterImageView")
        XCTAssertTrue(posterImageView.exists)
    
        
        let titleLabel = cellFirst.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(titleLabel.exists)
        XCTAssertEqual(titleLabel.label, "Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train")
        
        let dateLabel = cellFirst.staticTexts.element(matching: .any, identifier: "dateLabel")
        XCTAssertTrue(dateLabel.exists)
        XCTAssertEqual(dateLabel.label, "16-Oct-2020")
        
        let ratingLabel = cellFirst.staticTexts.element(matching: .any, identifier: "ratingLabel")
        XCTAssertTrue(ratingLabel.exists)
        XCTAssertEqual(ratingLabel.label, "6.3")
        
        cellFirst.tap()
        sleep(2)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
