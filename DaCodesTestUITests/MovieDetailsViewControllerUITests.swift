//
//  MovieDetailsViewControllerUITests.swift
//  DaCodesTestUITests
//
//  Created by Navneet Kaur on 11/10/20.
//

import XCTest

class MovieDetailsViewControllerUITests: XCTestCase {

    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments.append("isTestMode")
        app.launchArguments.append("NoAnimations")
        continueAfterFailure = false
        app.launch()
    }

    // Methos to navigte to movie detail screen.
    private func navigteToMovieDetailScreen() {
        let collectionFirstCell = app.collectionViews.cells.element(boundBy: 0)
        collectionFirstCell.tap()
        sleep(2)
    }
    
    func testMovieDetailsFlow() {
        // Navigte to movie detail screen.
        navigteToMovieDetailScreen()
        
        // Check poster in first table cell
        let tableFirstCell = app.tables.cells.element(boundBy: 0)
        let posterImageView = tableFirstCell.images.element(matching: .any, identifier: "posterImageView")
        XCTAssertTrue(posterImageView.exists)
    
        // Check the heder title
        let headerTitle = app.tables.staticTexts.element(matching: .any, identifier: "headerTitle")
        XCTAssertTrue(headerTitle.exists)
        XCTAssertEqual(headerTitle.label, "Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train")
        
        // Check first table cell
        let tableInfoFirstCell = app.tables.cells.element(boundBy: 1)
        let firstTitleLabel = tableInfoFirstCell.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(firstTitleLabel.exists)
        XCTAssertEqual(firstTitleLabel.label, "Duración:")
        let firstValueLabel = tableInfoFirstCell.staticTexts.element(matching: .any, identifier: "valueLabel")
        XCTAssertTrue(firstValueLabel.exists)
        XCTAssertEqual(firstValueLabel.label, "117")

        // Check second table cell
        let tableInfoSecondCell = app.tables.cells.element(boundBy: 2)
        let secondTitleLabel = tableInfoSecondCell.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(secondTitleLabel.exists)
        XCTAssertEqual(secondTitleLabel.label, "Fecha de estreno:")
        let secondValueLabel = tableInfoSecondCell.staticTexts.element(matching: .any, identifier: "valueLabel")
        XCTAssertTrue(secondValueLabel.exists)
        XCTAssertEqual(secondValueLabel.label, "16 October 2020")
        
        // Check third table cell
        let tableInfoThirdCell = app.tables.cells.element(boundBy: 3)
        let thirdTitleLabel = tableInfoThirdCell.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(thirdTitleLabel.exists)
        XCTAssertEqual(thirdTitleLabel.label, "Calificación:")
        let thirdValueLabel = tableInfoThirdCell.staticTexts.element(matching: .any, identifier: "valueLabel")
        XCTAssertTrue(thirdValueLabel.exists)
        XCTAssertEqual(thirdValueLabel.label, "3778.011")
        
        // Check fourth table cell
        let tableInfoFourthCell = app.tables.cells.element(boundBy: 4)
        let fourthTitleLabel = tableInfoFourthCell.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(fourthTitleLabel.exists)
        XCTAssertEqual(fourthTitleLabel.label, "Géneros:")
        let fourthValueLabel = tableInfoFourthCell.staticTexts.element(matching: .any, identifier: "valueLabel")
        XCTAssertTrue(fourthValueLabel.exists)
        XCTAssertEqual(fourthValueLabel.label, "Animation, Action, History, Adventure, Fantasy, Drama")
        
        // Check fifth table cell
        let tableInfoFifthCell = app.tables.cells.element(boundBy: 5)
        let fifthTitleLabel = tableInfoFifthCell.staticTexts.element(matching: .any, identifier: "titleLabel")
        XCTAssertTrue(fifthTitleLabel.exists)
        XCTAssertEqual(fifthTitleLabel.label, "Descripción:")
        let fifthValueLabel = tableInfoFifthCell.staticTexts.element(matching: .any, identifier: "valueLabel")
        XCTAssertTrue(fifthValueLabel.exists)
        XCTAssertEqual(fifthValueLabel.label, "Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar's head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!")
    }
    
    func testBackButton() {
        // Navigte to movie detail screen.
        navigteToMovieDetailScreen()
        
        // Check for left back button
        let backButton = app.navigationBars.buttons.element(matching: .any, identifier: "Películas")
        backButton.tap()
        sleep(2)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
