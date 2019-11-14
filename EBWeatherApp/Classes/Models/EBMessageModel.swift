//
//  EBMessageModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

struct EBMessageModel<T: Codable> {
    let message: String
    let code: String
    let count: Int
    let list: [T]

    init(message: String = "",
         code: String = "",
         count: Int = 0,
         list: [T] = []) {
        self.message = message
        self.code = code
        self.count = count
        self.list = list
    }
}

// MARK: - Codable

/**
 Input:
 {
     "message": "accurate",
     "cod": "200",
     "count": 10,
     "list": [T]
 }
 */
extension EBMessageModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case message
        case code = "cod"
        case count
        case list
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            message = try container.decode(.message)
        } catch {
            message = ""
        }

        do {
            code = try container.decode(.code)
        } catch {
            code = ""
        }

        if let countInt = try? container.decode(Int.self, forKey: .count) {
            count = countInt
        } else if let countDouble = try? container.decode(Double.self, forKey: .count) {
            count = Int(countDouble)
        } else if let countString = try? container.decode(String.self, forKey: .count) {
            count = Int(countString) ?? 0
        } else {
            count = Int(NSNotFound)
        }

        do {
            list = try container.decode(.list)
        } catch {
            list = []
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !message.isEmpty {
            try container.encode(message, forKey: .message)
        }
        if !code.isEmpty {
            try container.encode(code, forKey: .code)
        }
        if count != NSNotFound {
            try container.encode(count, forKey: .count)
        }
        if !list.isEmpty {
            try container.encode(list, forKey: .list)
        }
    }
}
