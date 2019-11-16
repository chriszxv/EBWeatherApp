//
//  EBTeamperatureModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import XCTest

class EBTeamperatureModelTests: XCTestCase {
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
                "temp": 25.1,
                "pressure": 1018,
                "humidity": 69,
                "temp_min": 22.78,
                "temp_max": 26.67
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBTemperatureModel.self, from: jsonData)

        XCTAssertEqual(object.temperature, 25.1)
        XCTAssertEqual(object.pressure, 1018)
        XCTAssertEqual(object.humidity, 69)
        XCTAssertEqual(object.mimimumTemperature, 22.78)
        XCTAssertEqual(object.maximumTemperature, 26.67)
        XCTAssertEqual(object.isValid, true)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"humidity":"69","temp_max":"26.67","temp_min":"22.78","temp":"25.1","pressure":"1018"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "temp": 25.1,
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBTemperatureModel.self, from: jsonData)

        XCTAssertEqual(object.temperature, 25.1)
        XCTAssertEqual(object.pressure.isNaN, true)
        XCTAssertEqual(object.humidity.isNaN, true)
        XCTAssertEqual(object.mimimumTemperature.isNaN, true)
        XCTAssertEqual(object.maximumTemperature.isNaN, true)
        XCTAssertEqual(object.isValid, false)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"temp":"25.1"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBTemperatureModel.self, from: jsonData)

        XCTAssertEqual(object.temperature.isNaN, true)
        XCTAssertEqual(object.pressure.isNaN, true)
        XCTAssertEqual(object.humidity.isNaN, true)
        XCTAssertEqual(object.mimimumTemperature.isNaN, true)
        XCTAssertEqual(object.maximumTemperature.isNaN, true)
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
