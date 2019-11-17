//
//  EBTemperatureModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBTemperatureModel {
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let mimimumTemperature: Double
    let maximumTemperature: Double

    init(temperature: Double = .nan,
         pressure: Double = .nan,
         humidity: Double = .nan,
         mimimumTemperature: Double = .nan,
         maximumTemperature: Double = .nan) {
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.mimimumTemperature = mimimumTemperature
        self.maximumTemperature = maximumTemperature
    }
}

// MARK: - Validation

extension EBTemperatureModel {
    var isValid: Bool {
        return !temperature.isNaN &&
            !pressure.isNaN &&
            !humidity.isNaN &&
            !maximumTemperature.isNaN &&
            !mimimumTemperature.isNaN
    }
}

// MARK: - Codable

/**
 {
 "temp": 25.1,
 "pressure": 1018,
 "humidity": 69,
 "temp_min": 22.78,
 "temp_max": 26.67
 }
 */
extension EBTemperatureModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case mimimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let valueDouble = try? container.decode(Double.self, forKey: .temperature) {
            temperature = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .temperature) {
            temperature = Double(valueString) ?? .nan
        } else {
            temperature = .nan
        }

        if let valueDouble = try? container.decode(Double.self, forKey: .pressure) {
            pressure = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .pressure) {
            pressure = Double(valueString) ?? .nan
        } else {
            pressure = .nan
        }

        if let valueDouble = try? container.decode(Double.self, forKey: .humidity) {
            humidity = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .humidity) {
            humidity = Double(valueString) ?? .nan
        } else {
            humidity = .nan
        }

        if let valueDouble = try? container.decode(Double.self, forKey: .mimimumTemperature) {
            mimimumTemperature = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .mimimumTemperature) {
            mimimumTemperature = Double(valueString) ?? .nan
        } else {
            mimimumTemperature = .nan
        }

        if let valueDouble = try? container.decode(Double.self, forKey: .maximumTemperature) {
            maximumTemperature = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .maximumTemperature) {
            maximumTemperature = Double(valueString) ?? .nan
        } else {
            maximumTemperature = .nan
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !temperature.isNaN {
            try container.encode(temperature.clean, forKey: .temperature)
        }
        if !pressure.isNaN {
            try container.encode(pressure.clean, forKey: .pressure)
        }
        if !humidity.isNaN {
            try container.encode(humidity.clean, forKey: .humidity)
        }
        if !mimimumTemperature.isNaN {
            try container.encode(mimimumTemperature.clean, forKey: .mimimumTemperature)
        }
        if !maximumTemperature.isNaN {
            try container.encode(maximumTemperature.clean, forKey: .maximumTemperature)
        }
    }
}
