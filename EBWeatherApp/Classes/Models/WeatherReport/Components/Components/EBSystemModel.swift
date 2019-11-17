//
//  EBSystemModel.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBSystemModel {
    let countryCode: String
    let timezone: Int

    init(countryCode: String = "",
         timezone: Int = 0) {
        self.countryCode = countryCode
        self.timezone = timezone
    }
}

// MARK: - Validation

extension EBSystemModel {
    var isValid: Bool {
        return !countryCode.isEmpty
    }
}

// MARK: - Codable

/**
 {
 "country": "HK",
 "timezone": 28800,
 "sunrise": 1573943798,
 "sunset": 1573983600
 }
 */
extension EBSystemModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case countryCode = "country"
        case timezone
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            countryCode = try container.decode(.countryCode)
        } catch {
            countryCode = ""
        }
        if let valueInt = try? container.decode(Int.self, forKey: .timezone) {
            timezone = valueInt
        } else if let valueDouble = try? container.decode(Double.self, forKey: .timezone) {
            timezone = Int(valueDouble)
        } else if let valueString = try? container.decode(String.self, forKey: .timezone) {
            timezone = Int(valueString) ?? 0
        } else {
            timezone = Int(NSNotFound)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !countryCode.isEmpty {
            try container.encode(countryCode, forKey: .countryCode)
        }
        if timezone != NSNotFound {
            try container.encode(timezone, forKey: .timezone)
        }
    }
}
