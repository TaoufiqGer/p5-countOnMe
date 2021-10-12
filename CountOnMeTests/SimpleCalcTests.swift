//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    let calculator = Calculator()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGivenExpIsAddition_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "3 + 2"
        calculator.result()
        XCTAssertEqual(calculator.elements.last!, "5")
    }
    
    func testGivenExpIsSubstraction_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "3 - 2"
        calculator.result()
        XCTAssert(calculator.elements.last! == "1")
        calculator.inputString = "2 - 4"
        calculator.result()
        XCTAssert(calculator.elements.last! == "-2")
    }
    
    func testGivenExpIsMultiplication_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "5 x 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "10")
    }
    
    func testGivenExpIsDivision_WhenEqualButtonIsPressed_ThenResultisPrinted() {
        calculator.inputString = "30 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "15.0")
        calculator.inputString = "1 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "0.5")
        calculator.inputString = "5 / 0"
        calculator.result()
    }
    
    func testGiven_When_Then() {
    }
    
    func testGivenHasNoOperation_WhenAdditionButtonIsPressed_ThenPlusSignShouldBeAdded() {
        calculator.inputString = "5"
        calculator.addAddition()
        XCTAssertEqual(calculator.elements.last!, "+")
    }
    
    func testGivenHasNoOperation_WhenSubstractionButtonIsPressed_ThenMinusSignShouldBeAdded() {
        calculator.inputString = "5"
        calculator.addSubstraction()
        XCTAssertEqual(calculator.elements.last!, "-")
    }
    
    func testGivenHasNoOperation_WhenMultiplicationButtonIsPressed_ThenMultiplicationSignShouldBeAdded() {
        calculator.inputString = "5"
        calculator.addMultiplication()
        XCTAssertEqual(calculator.elements.last!, "x")
    }
    
    func testGivenHasNoOperation_WhenDivisionButtonIsPressed_ThenDivisionSignShouldBeAdded() {
        calculator.inputString = "5"
        calculator.addDivision()
        XCTAssertEqual(calculator.elements.last!, "/")
    }
    
    func testGivenExpressionIsComplete_WhanEqualButtonIsPressed_ThenResultShouldBePrinted() {
        calculator.inputString = "1 + 1 ="
        XCTAssertTrue(calculator.expressionIsComplete)
    }

    func testGivenHasOperation_WhenOperandButtonIsPressed_ThenErrorShouldBeDisplayed() {
        calculator.inputString = "1 +"
        XCTAssertFalse(calculator.canAddOperator)
    }
}
