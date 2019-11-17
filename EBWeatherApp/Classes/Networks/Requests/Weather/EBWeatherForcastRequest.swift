//
//  EBWeatherForcastRequest.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

///**
// ?appid=fa50bf80f3aba874aca0a2ad48316afa
// &mode=json
// &units=metric
// &lang=zh_tw
// &id=1819729
// &cnt=40
// */
//final class EBWeatherForcastRequest: EBBaseRequest {
//    let method = EBRequestMethod.GET
//    let url = EBURLConstants.OpenWeather.GetWeatherForcast
//    let parameters: [String: String]
//
//    init(applicationID: String = EBRequestConstants.Value.ApplicationID,
//         temperatureFormat: EBRequestTemperatureFormat = .celsius,
//         language: EBRequestLanguage = .english,
//         cityID: String,
//         intervalCount: UInt = EBRequestConstants.Value.DefaultIntervalCount) {
//        var parameters: [String: String] = [:]
//
//        if !applicationID.isEmpty {
//            parameters[EBRequestConstants.Key.ApplicationID] = applicationID
//        }
//
//        parameters[EBRequestConstants.Key.ResponseFormat] = EBRequestConstants.Value.Json
//
//        if !temperatureFormat.rawValue.isEmpty {
//            parameters[EBRequestConstants.Key.TemperatureFormat] = temperatureFormat.rawValue
//        }
//
//        if !language.rawValue.isEmpty {
//            parameters[EBRequestConstants.Key.Language] = language.rawValue
//        }
//
//        if !cityID.isEmpty {
//            parameters[EBRequestConstants.Key.CityID] = cityID
//        }
//
//        if intervalCount > 0 {
//            parameters[EBRequestConstants.Key.Count] = String(intervalCount)
//        }
//
//        self.parameters = parameters
//    }
//}
