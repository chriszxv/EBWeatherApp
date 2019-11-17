//
//  EBWeatherModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import XCTest

class EBWeatherModelTests: XCTestCase {
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
                "id": 801,
                "main": "Clouds",
                "description": "晴，少雲",
                "icon": "02n"
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherModel.self, from: jsonData)

        XCTAssertEqual(object.weatherID, "801")
        XCTAssertEqual(object.value, "Clouds")
        XCTAssertEqual(object.description, "晴，少雲")
        XCTAssertEqual(object.iconID, "02n")
        XCTAssertEqual(object.dayKey, "n")
        XCTAssertEqual(object.isValid, true)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"id":"801","main":"Clouds","icon":"02n","description":"晴，少雲"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "id": 801,
                "main": "Clouds",
                "icon": "02n"
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherModel.self, from: jsonData)

        XCTAssertEqual(object.weatherID, "801")
        XCTAssertEqual(object.value, "Clouds")
        XCTAssertEqual(object.iconID, "02n")
        XCTAssertEqual(object.dayKey, "n")
        XCTAssertEqual(object.isValid, false)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"id":"801","main":"Clouds","icon":"02n"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherModel.self, from: jsonData)

        XCTAssertEqual(object.weatherID, "")
        XCTAssertEqual(object.value, "")
        XCTAssertEqual(object.description, "")
        XCTAssertEqual(object.iconID, "")
        XCTAssertEqual(object.dayKey, "")
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
