//
//  EBURLConstants.swift
//  EBWeatherApp
//
//  Created by product on 13/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

struct AATVURLConstants {
    private struct Config {
        private struct APIKeys {
            static let PRO = "fa50bf80f3aba874aca0a2ad48316afa"
            static let UAT = "b6907d289e10d714a6e88b30761fae22"
            static let DEV = "b6907d289e10d714a6e88b30761fae22"
        }

        private struct OpenWeatherDomains {
            static let PRO = "https://api.openweathermap.org"
            static let UAT = "https://samples.openweathermap.org"
            static let DEV = "https://samples.openweathermap.org"
        }

        // Change to Production stage
        static let APIKey = APIKeys.PRO
        static let OpenWeatherDomain = OpenWeatherDomains.PRO

        // Change to UAT stage
        //    private static let APIKey = APIKeys.UAT
        //    private static let OpenWeatherDomain = OpenWeatherDomains.UAT

        // Change to Development stage
        //    private static let APIKey = APIKeys.DEV
        //    private static let OpenWeatherDomain = OpenWeatherDomains.DEV
    }
}

// MARK: - Public

extension AATVURLConstants {
    struct OpenWeather {
        // AATVURLConstants.OpenWeather.Key.APIKey
        struct Key {
            static var APIKey: String {
                return Config.APIKey
            }

            // Additional keys append here
        }

        // AATVURLConstants.OpenWeather.Url.GetCurrentWeather
        struct Url {
            static var GetCurrentWeather: String {
                return Config.OpenWeatherDomain + "/data/2.5/weather"
            }

            // Additional urls append here
        }
    }
}
