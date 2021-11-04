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
        
        calculator.inputString = "10000000 + 500000"
        calculator.result()
        XCTAssertEqual(calculator.elements.last!, "10500000")
    }
    
    func testGivenExpIsSubstraction_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "3 - 2"
        calculator.result()
        XCTAssert(calculator.elements.last! == "1")
        
        calculator.inputString = "2 - 4"
        calculator.result()
        XCTAssert(calculator.elements.last! == "-2")
        
        calculator.inputString = "10000000 - 500000"
        calculator.result()
        XCTAssertEqual(calculator.elements.last!, "9500000")
    }
    
    func testGivenExpIsMultiplication_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "5 x 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "10")
        
        calculator.inputString = "100000000 x 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "200000000")
    }
    
    func testGivenExpIsDivision_WhenEqualButtonIsPressed_ThenResultisPrinted() {
        calculator.inputString = "30 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "15")
        
        calculator.inputString = "1 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "0.5")
        
        calculator.inputString = "1 / 3"
        calculator.result()
        XCTAssert(calculator.elements.last == "0.333")
    }
    
    func testGivenDenominatorIsZero_WhenEqualButtonIsPressed_ThenResultisPrinted() {
        calculator.inputString = "2 / 0"
        XCTAssertTrue(calculator.denominatorIsZero)
        
        calculator.inputString = "2 +"
        XCTAssertFalse(calculator.denominatorIsZero)
        
        calculator.inputString = "2 / 3"
        XCTAssertFalse(calculator.denominatorIsZero)
        
        calculator.inputString = "2 + 2 / 0"
        XCTAssertTrue(calculator.denominatorIsZero)
    }
    
    func testGivenHasMultipleOperations_WhenEqualButtonIsPressed_ThenResultisPrinted() {
        calculator.inputString = "1 + 3 x 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "7")
        calculator.inputString = "1 + 4 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "3")
        calculator.inputString = "3 + 4 x 8 / 2"
        calculator.result()
        XCTAssert(calculator.elements.last == "19")
        calculator.inputString = "1 + 2 x 3 / 3 x 2"
        calculator.result()
        XCTAssertEqual(calculator.elements.last, "5")
        calculator.inputString = "10 + 3 x 45 + 100 / 5"
        calculator.result()
        XCTAssertEqual(calculator.elements.last, "165")
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
        XCTAssertTrue(calculator.lastElementIsOperator)
    }

    func testGivenHasOperation_WhenOperandButtonIsPressed_ThenErrorShouldBeDisplayed() {
        calculator.inputString = "1 +"
        XCTAssertFalse(calculator.lastElementIsOperator)
    }
    
}
