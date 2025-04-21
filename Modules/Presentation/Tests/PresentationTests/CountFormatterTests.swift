//
//  CountFormatterTests.swift
//  Presentation
//
//  Created by Nhat Nguyen on 21/4/25.
//

import XCTest
@testable import Presentation

final class CountFormatterTests: XCTestCase {
    
    func testCountEqualToThreshold() {
        let result = CountFormatter.display(for: 100)
        XCTAssertEqual(result, "100")
    }
    
    func testCountAboveThreshold() {
        let result = CountFormatter.display(for: 150)
        XCTAssertEqual(result, "100+")
    }
     
    func testCustomThresholdBelow() {
        let result = CountFormatter.display(for: 999, threshold: 1000)
        XCTAssertEqual(result, "999")
    }
    
    func testCustomThresholdAbove() {
        let result = CountFormatter.display(for: 1200, threshold: 1000)
        XCTAssertEqual(result, "1000+")
    }
}
