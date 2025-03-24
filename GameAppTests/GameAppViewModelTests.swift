//
//  GameAppViewModelTests.swift
//  GameAppTests
//
//  Created on 24/03/2025.
//

import XCTest
@testable import GameApp
import Testing

class GameAppViewModelTests: XCTestCase {
    
    var viewModel: GameAppViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = GameAppViewModel()
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetQuestions() {
        viewModel.getQuestions()
        let exception = XCTestExpectation(description: "Waiting for data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.questions.count > 0)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 5)
    }
    func testSingleQuestion() {
        viewModel.questions = [
            Question(answerID: 1, countries: [Country(countryName: "USA", id: 1), Country(countryName: "Canada", id: 2)], countryCode: "US"),
            Question(answerID: 2, countries: [Country(countryName: "Japan", id: 3)], countryCode: "JP")
        ]
        viewModel.currentIndex = 0
        viewModel.singleQuestion()
        
        XCTAssertEqual(viewModel.answerID, 1)
        XCTAssertEqual(viewModel.countryCode, "US")
        XCTAssertEqual(viewModel.options.count, 2)
        XCTAssertEqual(viewModel.options[1], "USA")
        XCTAssertEqual(viewModel.options[2], "Canada")
        
        viewModel.currentIndex = 1
        viewModel.singleQuestion()
        
        XCTAssertEqual(viewModel.answerID, 2)
        XCTAssertEqual(viewModel.countryCode, "JP")
        XCTAssertEqual(viewModel.options.count, 3)
        XCTAssertEqual(viewModel.options[3], "Japan")
    }
    func testCheckAnswer_Correct() {
        viewModel.answerID = 1
        viewModel.checkAnswer(optionId: 1)
        XCTAssertTrue(viewModel.isCorrect)
    }
    
    func testCheckAnswer_Incorrect() {
        viewModel.answerID = 1
        viewModel.checkAnswer(optionId: 2)
        XCTAssertFalse(viewModel.isCorrect)
    }
    
}

