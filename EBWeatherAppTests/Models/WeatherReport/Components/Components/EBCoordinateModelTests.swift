//
//  EBCoordinateModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import XCTest

class EBCoordinateModelTests: XCTestCase {
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
                "lat": 22.2793,
                "lon": 114.1628
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBCoordinateModel.self, from: jsonData)

        XCTAssertEqual(object.latitude, 22.2793)
        XCTAssertEqual(object.longitude, 114.1628)
        XCTAssertEqual(object.isValid, true)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"lat":"22.2793","lon":"114.1628"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "lat": 22.2793,
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBCoordinateModel.self, from: jsonData)

        XCTAssertEqual(object.latitude, 22.2793)
        XCTAssertEqual(object.longitude.isNaN, true)
        XCTAssertEqual(object.isValid, false)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"lat":"22.2793"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBCoordinateModel.self, from: jsonData)

        XCTAssertEqual(object.latitude.isNaN, true)
        XCTAssertEqual(object.longitude.isNaN, true)
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
