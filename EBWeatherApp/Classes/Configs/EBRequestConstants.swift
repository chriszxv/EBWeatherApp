//
//  EBRequestConstants.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

struct EBRequestConstants {
    struct Key {
        static let ApplicationID = "appid"
        static let ResponseFormat = "mode"
        static let TemperatureFormat = "units"
        static let Language = "lang"
        static let CityName = "q"
        static let CityID = "id"
        static let Latitude = "lat"
        static let Longitude = "lon"
        static let Count = "cnt"
    }

    struct Value {
        static let ApplicationID = "fa50bf80f3aba874aca0a2ad48316afa"
        static let Json = "json"
        static let DefaultLocationSearchCount: UInt = 1 
        static let DefaultIntervalCount: UInt = 40 // maximum 5 days 3 hours = 5 * 24 / 3
    }
}

enum EBRequestLanguage: String {
    case English = "en"
    case ChineseTraditional = "zh_tw"
    case ChineseSimplified = "zh_cn"
    init(_ languageCode: String = "") {
        switch languageCode {
        case "en":
            self = .English
        case "tc":
            self = .ChineseTraditional
        case "sc":
            self = .ChineseSimplified
        default:
            self = .English
        }
    }
}

enum EBRequestTemperatureFormat: String {
    case Celsius = "imperial"
    case Fahrenheit = "metric"
}
