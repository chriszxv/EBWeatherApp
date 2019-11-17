//
//  EBURLConstants.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBURLConstants {
    private struct Config {
        private struct OpenWeatherDomains {
            static let PRO = "https://api.openweathermap.org"
            static let DEV = "https://api.openweathermap.org"
        }

        private struct Icon8Domains {
            static let PRO = "https://icons8.com"
            static let DEV = "https://icons8.com"
        }

        #if DEBUG
            // Change to Development stage
            static let OpenWeatherDomain = OpenWeatherDomains.DEV
            static let Icon8Domain = Icon8Domains.DEV
        #else
            // Change to Production stage
            static let OpenWeatherDomain = OpenWeatherDomains.PRO
            static let Icon8Domain = Icon8Domains.PRO

        #endif
    }
}

// MARK: - Public

// EBURLConstants.OpenWeather.Url.XXX

extension EBURLConstants {
    struct OpenWeather {
        static var GetWeatherForCityIDs: String {
            return Config.OpenWeatherDomain + "/data/2.5/group"
        }

        static var GetWeatherForCityID: String {
            return Config.OpenWeatherDomain + "/data/2.5/weather"
        }

        static var GetWeatherForCityName: String {
            return Config.OpenWeatherDomain + "/data/2.5/find"
        }

        static var GetWeatherForZipCode: String {
            return Config.OpenWeatherDomain + "/data/2.5/weather"
        }

        static var GetWeatherForLocation: String {
            return Config.OpenWeatherDomain + "/data/2.5/weather"
        }

//        static var GetWeatherForcast: String {
//            return Config.OpenWeatherDomain + "/data/2.5/forecast"
//        }
    }

    struct Icon8 {
        static var Reference: String {
            return Config.Icon8Domain + "/"
        }
    }
}
