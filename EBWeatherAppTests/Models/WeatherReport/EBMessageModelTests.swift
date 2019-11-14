//
//  EBMessageModelTests.swift
//  EBWeatherAppTests
//
//  Created by product on 14/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

@testable import EBWeatherApp
import Foundation
import XCTest

class EBMessageModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {
        let jsonString =
            """
            {
                "message": "init",
                "cod": "201",
                "count": 0,
                "list": []
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBMessageModel<Int>.self, from: jsonData)

        XCTAssertEqual(object.message, "init")
        XCTAssertEqual(object.code, "201")
        XCTAssertEqual(object.count, 0)
        XCTAssertEqual(object.list, [])

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"message":"init","cod":"201","count":0}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testNormal() {
        let jsonString =
            """
            {
                "message": "normal",
                "cod": "201",
                "count": 3,
                "list": [1, 2, 3]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBMessageModel<Int>.self, from: jsonData)

        XCTAssertEqual(object.message, "normal")
        XCTAssertEqual(object.code, "201")
        XCTAssertEqual(object.count, 3)
        XCTAssertEqual(object.list, [1, 2, 3])

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!
        let encodedString =
            """
            {"message":"normal","cod":"201","count":3,"list":[1,2,3]}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testIncomplete() {
        let jsonString =
            """
            {
                "message": "incomplete",
                "cod": "200",
                "list": [1, 2, 3]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBMessageModel<Int>.self, from: jsonData)

        XCTAssertEqual(object.message, "incomplete")
        XCTAssertEqual(object.code, "200")
        XCTAssertEqual(object.count, NSNotFound)
        XCTAssertEqual(object.list, [1, 2, 3])

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!

        let encodedString =
            """
            {"message":"incomplete","cod":"200","list":[1,2,3]}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testCorrupted() {
        let jsonString =
            """
            {
                "code": "???",
                "lis": [1,"2","3"],
                "ABC": "DEF"
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBMessageModel<Int>.self, from: jsonData)

        XCTAssertEqual(object.message, "")
        XCTAssertEqual(object.code, "")
        XCTAssertEqual(object.count, NSNotFound)
        XCTAssertEqual(object.list, [])

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!

        let encodedString =
            """
            {}
            """

        XCTAssertEqual(string, encodedString)
    }

    func testEmpty() {
        let jsonString =
            """
            {}
            """
        let jsonData = jsonString.data(using: .utf8)!
        let object = try! JSONDecoder().decode(EBMessageModel<Int>.self, from: jsonData)

        XCTAssertEqual(object.message, "")
        XCTAssertEqual(object.code, "")
        XCTAssertEqual(object.count, NSNotFound)
        XCTAssertEqual(object.list, [])

        let data = try! JSONEncoder().encode(object)
        let string = String(data: data, encoding: .utf8)!

        let encodedString =
            """
            {}
            """

        XCTAssertEqual(string, encodedString)
    }
}
