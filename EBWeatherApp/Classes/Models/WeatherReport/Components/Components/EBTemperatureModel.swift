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

        do {
            temperature = try container.decode(.temperature)
        } catch {
            temperature = .nan
        }
        do {
            pressure = try container.decode(.pressure)
        } catch {
            pressure = .nan
        }
        do {
            humidity = try container.decode(.humidity)
        } catch {
            humidity = .nan
        }
        do {
            mimimumTemperature = try container.decode(.mimimumTemperature)
        } catch {
            mimimumTemperature = .nan
        }
        do {
            maximumTemperature = try container.decode(.maximumTemperature)
        } catch {
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
