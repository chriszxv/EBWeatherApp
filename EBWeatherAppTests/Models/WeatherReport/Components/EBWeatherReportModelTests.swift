//
//  EBWeatherReportModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import XCTest

class EBWeatherReportModelTests: XCTestCase {
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
                "id": 1819729,
                "name": "Hong Kong",
                "dt": 1573651081,
                "coord": {
                    "lat": 22.2793,
                    "lon": 114.1628
                },
                "main": {
                    "temp": 25.1,
                    "pressure": 1018,
                    "humidity": 69,
                    "temp_min": 22.78,
                    "temp_max": 26.67
                },
                "wind": {
                    "speed": 2.1,
                    "deg": 60
                },
                "weather": [{
                    "id": 801,
                    "main": "Clouds",
                    "description": "晴，少雲",
                    "icon": "02n"
                }]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherReportModel.self, from: jsonData)

        XCTAssertEqual(object.cityID, "1819729")
        XCTAssertEqual(object.cityName, "Hong Kong")
        XCTAssertEqual(object.dateTime, 1573651081)
        XCTAssertEqual(object.displayDate, "2019-11-13 21:18:01")
        XCTAssertEqual(object.isValid, true)

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"wind":{"lat":"22.2793","lon":"114.1628"},"dt":"1573651081","id":"1819729","coord":{"lat":"22.2793","lon":"114.1628"},"weather":{"lat":"22.2793","lon":"114.1628"},"main":{"humidity":"69","temp_max":"26.67","temp_min":"22.78","temp":"25.1","pressure":"1018"},"name":"Hong Kong"}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "id": 1819729,
                "dt": 1573651081,
                "coord": {
                    "lat": 22.2793,
                },
                "main": {
                    "temp": 25.1,
                    "pressure": 1018,
                    "humidity": 69,
                    "temp_min": 22.78,
                },
                "wind": {
                    "speed": 2.1,
                },
                "weather": [{
                    "id": 801,
                    "main": "Clouds",
                    "description": "晴，少雲",
                }]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherReportModel.self, from: jsonData)

        XCTAssertEqual(object.cityID, "1819729")
        XCTAssertEqual(object.cityName, "")
        XCTAssertEqual(object.dateTime, 1573651081)
        XCTAssertEqual(object.displayDate, "2019-11-13 21:18:01")

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"id":"1819729","dt":"1573651081","weather":{"lat":"22.2793"}}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBWeatherReportModel.self, from: jsonData)

        XCTAssertEqual(object.cityID, "")
        XCTAssertEqual(object.cityName, "")
        XCTAssertEqual(object.dateTime.isNaN, true)
        XCTAssertEqual(object.displayDate, "yyyy-MM-dd HH:mm:ss")

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {}
            """

        XCTAssertEqual(string, encodedString)
    }
}
