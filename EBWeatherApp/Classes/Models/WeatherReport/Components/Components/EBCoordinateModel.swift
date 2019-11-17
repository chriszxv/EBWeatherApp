//
//  EBCoordinateModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 14/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBCoordinateModel {
    let latitude: Double
    let longitude: Double

    init(latitude: Double = .nan,
         longitude: Double = .nan) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: - Validation

extension EBCoordinateModel {
    var isValid: Bool {
        return !latitude.isNaN &&
            !longitude.isNaN
    }
}

// MARK: - Codable

/**
 {
 "lat": 22.2793,
 "lon": 114.1628
 }
 */
extension EBCoordinateModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let valueDouble = try? container.decode(Double.self, forKey: .latitude) {
            latitude = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .latitude) {
            latitude = Double(valueString) ?? .nan
        } else {
            latitude = .nan
        }
        
        if let valueDouble = try? container.decode(Double.self, forKey: .longitude) {
            longitude = valueDouble
        } else if let valueString = try? container.decode(String.self, forKey: .longitude) {
            longitude = Double(valueString) ?? .nan
        } else {
            longitude = .nan
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !latitude.isNaN {
            try container.encode(latitude.clean, forKey: .latitude)
        }
        if !longitude.isNaN {
            try container.encode(longitude.clean, forKey: .longitude)
        }
    }
}
