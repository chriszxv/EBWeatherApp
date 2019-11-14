//
//  EBWeatherModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 14/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBWeatherModel {
    let weatherID: String
    let value: String
    let description: String
    let iconID: String

    init(weatherID: String = "",
         value: String = "",
         description: String = "",
         iconID: String = "") {
        self.weatherID = weatherID
        self.value = value
        self.description = description
        self.iconID = iconID
    }
}

// MARK: - Validation

extension EBWeatherModel {
    var isValid: Bool {
        return !weatherID.isEmpty &&
            !value.isEmpty &&
            !description.isEmpty &&
            !iconID.isEmpty
    }
}

// MARK: - Codable

/**
 {
 "id": 801,
 "main": "Clouds",
 "description": "晴，少雲",
 "icon": "02n"
 }
 */
extension EBWeatherModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case weatherID = "id"
        case value = "main"
        case description
        case iconID = "icon"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let weatherIDString = try? container.decode(String.self, forKey: .weatherID) {
            weatherID = weatherIDString
        } else if let weatherIDDouble = try? container.decode(Double.self, forKey: .weatherID) {
            weatherID = String(format: "%.0f", weatherIDDouble)
        } else {
            weatherID = ""
        }

        do {
            value = try container.decode(.value)
        } catch {
            value = ""
        }
        do {
            description = try container.decode(.description)
        } catch {
            description = ""
        }
        do {
            iconID = try container.decode(.iconID)
        } catch {
            iconID = ""
        }
    }
}
