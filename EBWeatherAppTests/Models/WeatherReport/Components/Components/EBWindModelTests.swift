//
//  EBWindModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import XCTest

class EBWindModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testComplete() {
        let jsonString =
            """
            {
                "speed": 2.1,
                "deg": 60
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWindModel.self, from: jsonData)

        XCTAssertEqual(object.speed, 2.1)
        XCTAssertEqual(object.degrees, 60)
        XCTAssertEqual(object.isValid, true)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"speed":"2.1","deg":"60"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "speed": 2.1,
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWindModel.self, from: jsonData)

        XCTAssertEqual(object.speed, 2.1)
        XCTAssertEqual(object.degrees.isNaN, true)
        XCTAssertEqual(object.isValid, false)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"speed":"2.1"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWindModel.self, from: jsonData)

        XCTAssertEqual(object.speed.isNaN, true)
        XCTAssertEqual(object.degrees.isNaN, true)
        XCTAssertEqual(object.isValid, false)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {}
            """

        XCTAssertEqual(string, encodedString)
    }
}
