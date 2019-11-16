//
//  EBWeatherReportModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 14/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

struct EBWeatherReportModel {
    let cityID: String
    let cityName: String
    let dateTime: TimeInterval
    let coordinate: EBCoordinateModel
    let temperature: EBTemperatureModel
    let wind: EBWindModel
    let weather: [EBWeatherModel]

    var displayDate: String {
        if dateTime.isNaN {
            return "yyyy-MM-dd HH:mm:ss"
        } else {
            return Date(timeIntervalSince1970: dateTime).string(dateFormat: "yyyy-MM-dd HH:mm:ss")
        }
    }

    var displayDay: String {
        if dateTime.isNaN {
            return "yyyy-MM-dd HH:mm:ss"
        } else {
            return Date(timeIntervalSince1970: dateTime).string(dateFormat: "EEEE ⎯⎯⎯⎯⎯ MMM d")
        }
    }

    var displayTime: String {
        if dateTime.isNaN {
            return "HH:mm"
        } else {
            return Date(timeIntervalSince1970: dateTime).string(dateFormat: "HH:mm")
        }
    }

    var firstWeather: EBWeatherModel {
        if weather.isEmpty {
            return EBWeatherModel()
        } else {
            return weather[0]
        }
    }

    init(cityID: String = "",
         cityName: String = "",
         dateTime: TimeInterval = .nan,
         coordinate: EBCoordinateModel = EBCoordinateModel(),
         temperature: EBTemperatureModel = EBTemperatureModel(),
         wind: EBWindModel = EBWindModel(),
         weather: [EBWeatherModel] = []) {
        self.cityID = cityID
        self.cityName = cityName
        self.dateTime = dateTime
        self.coordinate = coordinate
        self.temperature = temperature
        self.wind = wind
        self.weather = weather
    }
}

// MARK: - Validation

extension EBWeatherReportModel {
    var isValid: Bool {
        return !cityID.isEmpty
    }
}

// MARK: - Codable

/**
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
 */
extension EBWeatherReportModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case cityID = "id"
        case cityName = "name"
        case dateTime = "dt"
        case coordinate = "coord"
        case temperature = "main"
        case wind
        case weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let cityIDString = try? container.decode(String.self, forKey: .cityID) {
            cityID = cityIDString
        } else if let cityIDDouble = try? container.decode(Double.self, forKey: .cityID) {
            cityID = String(format: "%.0f", cityIDDouble)
        } else {
            cityID = ""
        }

        do {
            cityName = try container.decode(.cityName)
        } catch {
            cityName = ""
        }

        if let dateTimeTimeInterval = try? container.decode(TimeInterval.self, forKey: .dateTime) {
            dateTime = dateTimeTimeInterval
        } else if let dateTimeString = try? container.decode(String.self, forKey: .dateTime) {
            dateTime = TimeInterval(dateTimeString) ?? .nan
        } else {
            dateTime = .nan
        }

        do {
            coordinate = try container.decode(.coordinate)
        } catch {
            coordinate = EBCoordinateModel()
        }

        do {
            temperature = try container.decode(.temperature)
        } catch {
            temperature = EBTemperatureModel()
        }

        do {
            wind = try container.decode(.wind)
        } catch {
            wind = EBWindModel()
        }

        do {
            weather = try container.decode(.weather)
        } catch {
            weather = []
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !cityID.isEmpty {
            try container.encode(cityID, forKey: .cityID)
        }
        if !cityName.isEmpty {
            try container.encode(cityName, forKey: .cityName)
        }
        if !dateTime.isNaN {
            try container.encode(dateTime.clean, forKey: .dateTime)
        }
        if coordinate.isValid {
            try container.encode(coordinate, forKey: .coordinate)
        }
        if temperature.isValid {
            try container.encode(temperature, forKey: .temperature)
        }
        if wind.isValid {
            try container.encode(coordinate, forKey: .wind)
        }
        if !weather.isEmpty {
            try container.encode(coordinate, forKey: .weather)
        }
    }
}
