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
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: Thunderstorm with Rain

        "201": [
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: Thunderstorm with Heavy Rain

        "202": [
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: Light Thunderstorm

        "210": [
            "d": R.image.icon.weather.storm_light.name,
            "n": R.image.icon.weather.storm_light.name,
        ],

        // MARK: Thunderstorm

        "211": [
            "d": R.image.icon.weather.storm_light.name,
            "n": R.image.icon.weather.storm_light.name,
        ],

        // MARK: Heavy Thunderstorm

        "212": [
            "d": R.image.icon.weather.storm_heavy.name,
            "n": R.image.icon.weather.storm_heavy.name,
        ],

        // MARK: Ragged Thunderstorm

        "221": [
            "d": R.image.icon.weather.storm_heavy.name,
            "n": R.image.icon.weather.storm_heavy.name,
        ],

        // MARK: Thunderstorm with Light Drizzle

        "230": [
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: Thunderstorm with Drizzle

        "231": [
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: Thunderstorm with Heavy Drizzle

        "232": [
            "d": R.image.icon.weather.storm_rain.name,
            "n": R.image.icon.weather.storm_rain.name,
        ],

        // MARK: - Group 3xx: Drizzle

        // MARK: Light Intensity Drizzle

        "300": [
            "d": R.image.icon.weather.drizzle_light.name,
            "n": R.image.icon.weather.drizzle_light.name,
        ],

        // MARK: Drizzle

        "301": [
            "d": R.image.icon.weather.drizzle_light.name,
            "n": R.image.icon.weather.drizzle_light.name,
        ],

        // MARK: Heavy Intensity Drizzle

        "302": [
            "d": R.image.icon.weather.drizzle.name,
            "n": R.image.icon.weather.drizzle.name,
        ],

        // MARK: Light Intensity Drizzle Rain

        "310": [
            "d": R.image.icon.weather.drizzle.name,
            "n": R.image.icon.weather.drizzle.name,
        ],

        // MARK: Drizzle Rain

        "311": [
            "d": R.image.icon.weather.drizzle.name,
            "n": R.image.icon.weather.drizzle.name,
        ],

        // MARK: Heavy Intensity Drizzle Rain

        "312": [
            "d": R.image.icon.weather.drizzle_heavy.name,
            "n": R.image.icon.weather.drizzle_heavy.name,
        ],

        // MARK: Shower Rain and Drizzle

        "313": [
            "d": R.image.icon.weather.drizzle_heavy.name,
            "n": R.image.icon.weather.drizzle_heavy.name,
        ],

        // MARK: Heavy Shower Rain and Drizzle

        "314": [
            "d": R.image.icon.weather.drizzle_heavy.name,
            "n": R.image.icon.weather.drizzle_heavy.name,
        ],

        // MARK: Shower Drizzle

        "321": [
            "d": R.image.icon.weather.drizzle_heavy.name,
            "n": R.image.icon.weather.drizzle_heavy.name,
        ],

        // MARK: - Group 5xx: Rain

        // MARK: Light Rain

        "500": [
            "d": R.image.icon.weather.rain_light.name,
            "n": R.image.icon.weather.rain_light.name,
        ],

        // MARK: Moderate Rain

        "501": [
            "d": R.image.icon.weather.rain_light.name,
            "n": R.image.icon.weather.rain_light.name,
        ],

        // MARK: Heavy Intensity Rain

        "502": [
            "d": R.image.icon.weather.rain.name,
            "n": R.image.icon.weather.rain.name,
        ],

        // MARK: Very Heavy Rain

        "503": [
            "d": R.image.icon.weather.rain.name,
            "n": R.image.icon.weather.rain.name,
        ],

        // MARK: Extreme Rain

        "504": [
            "d": R.image.icon.weather.rain.name,
            "n": R.image.icon.weather.rain.name,
        ],

        // MARK: Freezing Rain

        "511": [
            "d": R.image.icon.weather.rain.name,
            "n": R.image.icon.weather.rain.name,
        ],

        // MARK: Light Intensity Shower Rain

        "520": [
            "d": R.image.icon.weather.rain_heavy.name,
            "n": R.image.icon.weather.rain_heavy.name,
        ],

        // MARK: Shower Rain

        "521": [
            "d": R.image.icon.weather.rain_heavy.name,
            "n": R.image.icon.weather.rain_heavy.name,
        ],

        // MARK: Heavy Intensity Shower Rain

        "522": [
            "d": R.image.icon.weather.rain_heavy.name,
            "n": R.image.icon.weather.rain_heavy.name,
        ],

        // MARK: Ragged Shower Rain

        "531": [
            "d": R.image.icon.weather.rain_heavy.name,
            "n": R.image.icon.weather.rain_heavy.name,
        ],

        // MARK: - Group 6xx: Snow

        // MARK: Light Snow

        "600": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Snow

        "601": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Heavy Snow

        "602": [
            "d": R.image.icon.weather.snow_heavy.name,
            "n": R.image.icon.weather.snow_heavy.name,
        ],

        // MARK: Sleet

        "611": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Light Shower Sleet

        "612": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Shower Sleet

        "613": [
            "d": R.image.icon.weather.snow_heavy.name,
            "n": R.image.icon.weather.snow_heavy.name,
        ],

        // MARK: Light Rain and Snow

        "615": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Rain and Snow

        "616": [
            "d": R.image.icon.weather.snow_heavy.name,
            "n": R.image.icon.weather.snow_heavy.name,
        ],

        // MARK: Light Shower Snow

        "620": [
            "d": R.image.icon.weather.snow_light.name,
            "n": R.image.icon.weather.snow_light.name,
        ],

        // MARK: Shower Snow

        "621": [
            "d": R.image.icon.weather.snow_heavy.name,
            "n": R.image.icon.weather.snow_heavy.name,
        ],

        // MARK: Heavy Shower Snow

        "622": [
            "d": R.image.icon.weather.snow_heavy.name,
            "n": R.image.icon.weather.snow_heavy.name,
        ],

        // MARK: - Group 7xx: Atmosphere

        // MARK: Mist

        "701": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Smoke

        "711": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Haze

        "721": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Sand/ Dust Whirls

        "731": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Fog

        "741": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Sand

        "751": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Dust

        "761": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Volcanic Ash

        "762": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Squalls

        "771": [
            "d": R.image.icon.weather.fog_day.name,
            "n": R.image.icon.weather.fog_night.name,
        ],

        // MARK: Tornado

        "781": [
            "d": R.image.icon.weather.tornado.name,
            "n": R.image.icon.weather.tornado.name,
        ],

        // MARK: - Group 800: Clear

        // MARK: Clear Sky

        "800": [
            "d": R.image.icon.weather.clear_day.name,
            "n": R.image.icon.weather.clear_night.name,
        ],

        // MARK: - Group 80x: Clouds

        // MARK: Few Clouds:, 11_25%

        "801": [
            "d": R.image.icon.weather.cloudy_day.name,
            "n": R.image.icon.weather.cloudy_night.name,
        ],

        // MARK: Scattered Clouds:, 25_50%

        "802": [
            "d": R.image.icon.weather.cloudy_day.name,
            "n": R.image.icon.weather.cloudy_night.name,
        ],

        // MARK: Broken Clouds:, 51_84%

        "803": [
            "d": R.image.icon.weather.cloudy.name,
            "n": R.image.icon.weather.cloudy.name,
        ],

        // MARK: Overcast Clouds:, 85_100%

        "804": [
            "d": R.image.icon.weather.cloudy_heavy.name,
            "n": R.image.icon.weather.cloudy_heavy.name,
        ],
    ]

    static func imageKey(for weatherID: String, _ dayKey: String, isFilled: Bool = false) -> String? {
        guard let imageKey = weatherIDImageKeyDictionary[weatherID]?[dayKey] else {
            return nil
        }
        let suffix = isFilled ? "_filled" : ""
        return imageKey + suffix
    }
}
