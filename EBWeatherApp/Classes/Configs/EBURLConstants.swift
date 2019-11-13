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
            static let UAT = "https://samples.openweathermap.org"
            static let DEV = "https://samples.openweathermap.org"
        }

        // Change to Production stage
        static let OpenWeatherDomain = OpenWeatherDomains.PRO

        // Change to UAT stage
        //    private static let OpenWeatherDomain = OpenWeatherDomains.UAT

        // Change to Development stage
        //    private static let OpenWeatherDomain = OpenWeatherDomains.DEV
    }
}

// MARK: - Public

// EBURLConstants.OpenWeather.Url.XXX

extension EBURLConstants {
    struct OpenWeather {
        struct Url {
            static var GetWeatherForLocationRequest: String {
                return Config.OpenWeatherDomain + "/data/2.5/find"
            }

            static var GetWeatherForcast: String {
                return Config.OpenWeatherDomain + "/data/2.5/forecast"
            }

            static var GetCurrentWeatherForIDs: String {
                return Config.OpenWeatherDomain + "/data/2.5/group"
            }
        }
    }
}
