//
//  EBWindModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 14/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBWindModel {
    let speed: Double
    let degrees: Double
    init(speed: Double = .nan,
         degrees: Double = .nan) {
        self.speed = speed
        self.degrees = degrees
    }
}

// MARK: - Validation

extension EBWindModel {
    var isValid: Bool {
        return !speed.isNaN &&
            !degrees.isNaN
    }
}

// MARK: - Codable

/**
 {
 "speed": 2.1,
 "deg": 60
 }
 */

extension EBWindModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            speed = try container.decode(.speed)
        } catch {
            speed = .nan
        }
        do {
            degrees = try container.decode(.degrees)
        } catch {
            degrees = .nan
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if !speed.isNaN {
            try container.encode(speed.clean, forKey: .speed)
        }
        if !degrees.isNaN {
            try container.encode(degrees.clean, forKey: .degrees)
        }
    }
}
