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
        calculator.inputString = "3+2"
        XCTAssert(calculator.elements.last == "5")
    }
    
    func testGivenExpIsSubstraction_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "3-2"
        XCTAssert(calculator.elements.last == "1")
        calculator.inputString = "2-4"
        XCTAssert(calculator.elements.last == "-2")
    }
    
    func testGivenExpIsMultiplication_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "5x2"
        XCTAssert(calculator.elements.last == "10")
    }
    
    func testGivenExpIsDivision_WhenEqualButtonIspressed_ThenResultisPrinted() {
        calculator.inputString = "30/2"
        XCTAssert(calculator.elements.last == "15")
        calculator.inputString = "1/2"
        XCTAssert(calculator.elements.last == "0.5")
    }
}
