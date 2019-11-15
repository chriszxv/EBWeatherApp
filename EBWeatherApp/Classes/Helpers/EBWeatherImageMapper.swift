//
//  EBWeatherImageMapper.swift
//  EBWeatherApp
//
//  Created by product on 13/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

final class EBWeatherImageMapper {
    private static let weatherIDImageKeyDictionary = [
        // MARK: - Group 2xx: Thunderstorm

        // MARK: Thunderstorm with Light Rain

        "200": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: Thunderstorm with Rain

        "201": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: Thunderstorm with Heavy Rain

        "202": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: Light Thunderstorm

        "210": [
            "d": "icon-storm-light",
            "n": "icon-storm-light",
        ],

        // MARK: Thunderstorm

        "211": [
            "d": "icon-storm-light",
            "n": "icon-storm-light",
        ],

        // MARK: Heavy Thunderstorm

        "212": [
            "d": "icon-storm-heavy",
            "n": "icon-storm-heavy",
        ],

        // MARK: Ragged Thunderstorm

        "221": [
            "d": "icon-storm-heavy",
            "n": "icon-storm-heavy",
        ],

        // MARK: Thunderstorm with Light Drizzle

        "230": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: Thunderstorm with Drizzle

        "231": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: Thunderstorm with Heavy Drizzle

        "232": [
            "d": "icon-storm-rain",
            "n": "icon-storm-rain",
        ],

        // MARK: - Group 3xx: Drizzle

        // MARK: Light Intensity Drizzle

        "300": [
            "d": "icon-drizzle-light",
            "n": "icon-drizzle-light",
        ],

        // MARK: Drizzle

        "301": [
            "d": "icon-drizzle-light",
            "n": "icon-drizzle-light",
        ],

        // MARK: Heavy Intensity Drizzle

        "302": [
            "d": "icon-drizzle",
            "n": "icon-drizzle",
        ],

        // MARK: Light Intensity Drizzle Rain

        "310": [
            "d": "icon-drizzle",
            "n": "icon-drizzle",
        ],

        // MARK: Drizzle Rain

        "311": [
            "d": "icon-drizzle",
            "n": "icon-drizzle",
        ],

        // MARK: Heavy Intensity Drizzle Rain

        "312": [
            "d": "icon-drizzle-heavy",
            "n": "icon-drizzle-heavy",
        ],

        // MARK: Shower Rain and Drizzle

        "313": [
            "d": "icon-drizzle-heavy",
            "n": "icon-drizzle-heavy",
        ],

        // MARK: Heavy Shower Rain and Drizzle

        "314": [
            "d": "icon-drizzle-heavy",
            "n": "icon-drizzle-heavy",
        ],

        // MARK: Shower Drizzle

        "321": [
            "d": "icon-drizzle-heavy",
            "n": "icon-drizzle-heavy",
        ],

        // MARK: - Group 5xx: Rain

        // MARK: Light Rain

        "500": [
            "d": "icon-rain-light",
            "n": "icon-rain-light",
        ],

        // MARK: Moderate Rain

        "501": [
            "d": "icon-rain-light",
            "n": "icon-rain-light",
        ],

        // MARK: Heavy Intensity Rain

        "502": [
            "d": "icon-rain",
            "n": "icon-rain",
        ],

        // MARK: Very Heavy Rain

        "503": [
            "d": "icon-rain",
            "n": "icon-rain",
        ],

        // MARK: Extreme Rain

        "504": [
            "d": "icon-rain",
            "n": "icon-rain",
        ],

        // MARK: Freezing Rain

        "511": [
            "d": "icon-rain",
            "n": "icon-rain",
        ],

        // MARK: Light Intensity Shower Rain

        "520": [
            "d": "icon-rain-heavy",
            "n": "icon-rain-heavy",
        ],

        // MARK: Shower Rain

        "521": [
            "d": "icon-rain-heavy",
            "n": "icon-rain-heavy",
        ],

        // MARK: Heavy Intensity Shower Rain

        "522": [
            "d": "icon-rain-heavy",
            "n": "icon-rain-heavy",
        ],

        // MARK: Ragged Shower Rain

        "531": [
            "d": "icon-rain-heavy",
            "n": "icon-rain-heavy",
        ],

        // MARK: - Group 6xx: Snow

        // MARK: Light Snow

        "600": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Snow

        "601": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Heavy Snow

        "602": [
            "d": "icon-snow",
            "n": "icon-snow",
        ],

        // MARK: Sleet

        "611": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Light Shower Sleet

        "612": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Shower Sleet

        "613": [
            "d": "icon-snow",
            "n": "icon-snow",
        ],

        // MARK: Light Rain and Snow

        "615": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Rain and Snow

        "616": [
            "d": "icon-snow",
            "n": "icon-snow",
        ],

        // MARK: Light Shower Snow

        "620": [
            "d": "icon-snow-light",
            "n": "icon-snow-light",
        ],

        // MARK: Shower Snow

        "621": [
            "d": "icon-snow",
            "n": "icon-snow",
        ],

        // MARK: Heavy Shower Snow

        "622": [
            "d": "icon-snow",
            "n": "icon-snow",
        ],

        // MARK: - Group 7xx: Atmosphere

        // MARK: Mist

        "701": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Smoke

        "711": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Haze

        "721": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Sand/ Dust Whirls

        "731": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Fog

        "741": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Sand

        "751": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Dust

        "761": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Volcanic Ash

        "762": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Squalls

        "771": [
            "d": "icon-fog-day",
            "n": "icon-fog-night",
        ],

        // MARK: Tornado

        "781": [
            "d": "icon-tornado",
            "n": "icon-tornado",
        ],

        // MARK: - Group 800: Clear

        // MARK: Clear Sky

        "800": [
            "d": "icon-clear-day",
            "n": "icon-clear-night",
        ],

        // MARK: - Group 80x: Clouds

        // MARK: Few Clouds:, 11-25%

        "801": [
            "d": "icon-cloudy-day",
            "n": "icon-cloudy-night",
        ],

        // MARK: Scattered Clouds:, 25-50%

        "802": [
            "d": "icon-cloudy-day",
            "n": "icon-cloudy-night",
        ],

        // MARK: Broken Clouds:, 51-84%

        "803": [
            "d": "icon-cloudy",
            "n": "icon-cloudy",
        ],

        // MARK: Overcast Clouds:, 85-100%

        "804": [
            "d": "icon-cloudy",
            "n": "icon-cloudy",
        ],
    ]

    static func imageKey(for weatherID: String, _ dayKey: String, isFilled: Bool) -> String? {
        guard let imageKey = weatherIDImageKeyDictionary[weatherID]?[dayKey] else {
            return nil
        }
        let suffix = isFilled ? "-filled" : ""
        return "weather/" + imageKey + suffix
    }
}
