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
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: Thunderstorm with Rain

        "201": [
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: Thunderstorm with Heavy Rain

        "202": [
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: Light Thunderstorm

        "210": [
            "d": "storm_light",
            "n": "storm_light",
        ],

        // MARK: Thunderstorm

        "211": [
            "d": "storm_light",
            "n": "storm_light",
        ],

        // MARK: Heavy Thunderstorm

        "212": [
            "d": "storm_heavy",
            "n": "storm_heavy",
        ],

        // MARK: Ragged Thunderstorm

        "221": [
            "d": "storm_heavy",
            "n": "storm_heavy",
        ],

        // MARK: Thunderstorm with Light Drizzle

        "230": [
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: Thunderstorm with Drizzle

        "231": [
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: Thunderstorm with Heavy Drizzle

        "232": [
            "d": "storm_rain",
            "n": "storm_rain",
        ],

        // MARK: - Group 3xx: Drizzle

        // MARK: Light Intensity Drizzle

        "300": [
            "d": "drizzle_light",
            "n": "drizzle_light",
        ],

        // MARK: Drizzle

        "301": [
            "d": "drizzle_light",
            "n": "drizzle_light",
        ],

        // MARK: Heavy Intensity Drizzle

        "302": [
            "d": "drizzle",
            "n": "drizzle",
        ],

        // MARK: Light Intensity Drizzle Rain

        "310": [
            "d": "drizzle",
            "n": "drizzle",
        ],

        // MARK: Drizzle Rain

        "311": [
            "d": "drizzle",
            "n": "drizzle",
        ],

        // MARK: Heavy Intensity Drizzle Rain

        "312": [
            "d": "drizzle_heavy",
            "n": "drizzle_heavy",
        ],

        // MARK: Shower Rain and Drizzle

        "313": [
            "d": "drizzle_heavy",
            "n": "drizzle_heavy",
        ],

        // MARK: Heavy Shower Rain and Drizzle

        "314": [
            "d": "drizzle_heavy",
            "n": "drizzle_heavy",
        ],

        // MARK: Shower Drizzle

        "321": [
            "d": "drizzle_heavy",
            "n": "drizzle_heavy",
        ],

        // MARK: - Group 5xx: Rain

        // MARK: Light Rain

        "500": [
            "d": "rain_light",
            "n": "rain_light",
        ],

        // MARK: Moderate Rain

        "501": [
            "d": "rain_light",
            "n": "rain_light",
        ],

        // MARK: Heavy Intensity Rain

        "502": [
            "d": "rain",
            "n": "rain",
        ],

        // MARK: Very Heavy Rain

        "503": [
            "d": "rain",
            "n": "rain",
        ],

        // MARK: Extreme Rain

        "504": [
            "d": "rain",
            "n": "rain",
        ],

        // MARK: Freezing Rain

        "511": [
            "d": "rain",
            "n": "rain",
        ],

        // MARK: Light Intensity Shower Rain

        "520": [
            "d": "rain_heavy",
            "n": "rain_heavy",
        ],

        // MARK: Shower Rain

        "521": [
            "d": "rain_heavy",
            "n": "rain_heavy",
        ],

        // MARK: Heavy Intensity Shower Rain

        "522": [
            "d": "rain_heavy",
            "n": "rain_heavy",
        ],

        // MARK: Ragged Shower Rain

        "531": [
            "d": "rain_heavy",
            "n": "rain_heavy",
        ],

        // MARK: - Group 6xx: Snow

        // MARK: Light Snow

        "600": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Snow

        "601": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Heavy Snow

        "602": [
            "d": "snow",
            "n": "snow",
        ],

        // MARK: Sleet

        "611": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Light Shower Sleet

        "612": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Shower Sleet

        "613": [
            "d": "snow",
            "n": "snow",
        ],

        // MARK: Light Rain and Snow

        "615": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Rain and Snow

        "616": [
            "d": "snow",
            "n": "snow",
        ],

        // MARK: Light Shower Snow

        "620": [
            "d": "snow_light",
            "n": "snow_light",
        ],

        // MARK: Shower Snow

        "621": [
            "d": "snow",
            "n": "snow",
        ],

        // MARK: Heavy Shower Snow

        "622": [
            "d": "snow",
            "n": "snow",
        ],

        // MARK: - Group 7xx: Atmosphere

        // MARK: Mist

        "701": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Smoke

        "711": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Haze

        "721": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Sand/ Dust Whirls

        "731": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Fog

        "741": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Sand

        "751": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Dust

        "761": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Volcanic Ash

        "762": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Squalls

        "771": [
            "d": "fog_day",
            "n": "fog_night",
        ],

        // MARK: Tornado

        "781": [
            "d": "tornado",
            "n": "tornado",
        ],

        // MARK: - Group 800: Clear

        // MARK: Clear Sky

        "800": [
            "d": "clear_day",
            "n": "clear_night",
        ],

        // MARK: - Group 80x: Clouds

        // MARK: Few Clouds:, 11_25%

        "801": [
            "d": "cloudy_day",
            "n": "cloudy_night",
        ],

        // MARK: Scattered Clouds:, 25_50%

        "802": [
            "d": "cloudy_day",
            "n": "cloudy_night",
        ],

        // MARK: Broken Clouds:, 51_84%

        "803": [
            "d": "cloudy",
            "n": "cloudy",
        ],

        // MARK: Overcast Clouds:, 85_100%

        "804": [
            "d": "cloudy_heavy",
            "n": "cloudy_heavy",
        ],
    ]

    static func imageKey(for weatherID: String, _ dayKey: String, isFilled: Bool = false) -> String? {
        guard let imageKey = weatherIDImageKeyDictionary[weatherID]?[dayKey] else {
            return nil
        }
        let suffix = isFilled ? "_filled" : ""
        return "icon/weather/" + imageKey + suffix
    }
}
