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
    let timezone: Int
    let system: EBSystemModel
    let coordinate: EBCoordinateModel
    let temperature: EBTemperatureModel
    let wind: EBWindModel
    let weather: [EBWeatherModel]
    var displayDate: String {
        if dateTime.isNaN {
            return "yyyy-MM-dd HH:mm:ss"
        } else {
            return Date(timeIntervalSince1970: dateTime)
                .string(dateFormat: "yyyy-MM-dd HH:mm:ss",
                        timeZone: TimeZone(secondsFromGMT: timezone) ?? TimeZone.HongKongTimeZone())
        }
    }

    var displayDay: String {
        if dateTime.isNaN {
            return "EEEE ⎯⎯⎯⎯⎯ MMM d HH:mm"
        } else {
            return Date(timeIntervalSince1970: dateTime)
                .string(dateFormat: "EEEE ⎯⎯⎯⎯⎯ MMM d HH:mm",
                        timeZone: TimeZone(secondsFromGMT: timezone) ?? TimeZone.HongKongTimeZone())
        }
    }

    var displayTime: String {
        if dateTime.isNaN {
            return "HH:mm"
        } else {
            return Date(timeIntervalSince1970: dateTime)
                .string(dateFormat: "HH:mm",
                        timeZone: TimeZone(secondsFromGMT: system.timezone) ?? TimeZone.HongKongTimeZone())
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
         timezone: Int = 0,
         system: EBSystemModel = EBSystemModel(),
         coordinate: EBCoordinateModel = EBCoordinateModel(),
         temperature: EBTemperatureModel = EBTemperatureModel(),
         wind: EBWindModel = EBWindModel(),
         weather: [EBWeatherModel] = []) {
        self.cityID = cityID
        self.cityName = cityName
        self.dateTime = dateTime
        self.timezone = timezone
        self.system = system
        self.coordinate = coordinate
        self.temperature = temperature
        self.wind = wind
        self.weather = weather
    }
}

// MARK: - Validation

extension EBWeatherReportModel {
    var isValid: Bool {
        return !cityID.isEmpty && cityID != "0"
    }
}

// MARK: - Codable

/**
 {
     "id": 1819729,
     "name": "Hong Kong",
     "dt": 1573651081,
     "timezone": 28800,
     "sys": {
       "country": "HK",
       "timezone": 28800,
       "sunrise": 1573943798,
       "sunset": 1573983600
     },
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
        case timezone
        case system = "sys"
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

        if let valueTimeInterval = try? container.decode(TimeInterval.self, forKey: .dateTime) {
            dateTime = valueTimeInterval
        } else if let valueString = try? container.decode(String.self, forKey: .dateTime) {
            dateTime = TimeInterval(valueString) ?? .nan
        } else {
            dateTime = .nan
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

        do {
            system = try container.decode(.system)
        } catch {
            system = EBSystemModel()
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
        if timezone != NSNotFound {
            try container.encode(timezone, forKey: .timezone)
        }
        if system.isValid {
            try container.encode(system, forKey: .system)
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
