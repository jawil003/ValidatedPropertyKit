//
//  ValidationComparableTests.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationComparableTests: XCTestCase {
    
    func testLess() {
        let input1 = Int.random(in: 0...500)
        let input2 = Int.random(in: 0...500)
        let validation = Validation<Int>.less(input2)
        XCTAssertEqual(input1 < input2, validation.isValid(value: input1))
    }
    
    func testLessOrEqual() {
        let input1 = Int.random(in: 0...500)
        let input2 = Int.random(in: 0...500)
        let validation = Validation<Int>.lessOrEqual(input2)
        XCTAssertEqual(input1 <= input2, validation.isValid(value: input1))
    }
    
    func testGreater() {
        let input1 = Int.random(in: 0...500)
        let input2 = Int.random(in: 0...500)
        let validation = Validation<Int>.greater(input2)
        XCTAssertEqual(input1 > input2, validation.isValid(value: input1))
    }
    
    func testGreaterOrEqual() {
        let input1 = Int.random(in: 0...500)
        let input2 = Int.random(in: 0...500)
        let validation = Validation<Int>.greaterOrEqual(input2)
        XCTAssertEqual(input1 >= input2, validation.isValid(value: input1))
    }
    
}
