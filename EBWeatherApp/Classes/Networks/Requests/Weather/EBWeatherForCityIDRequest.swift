//
//  EBWeatherForCityIDRequest.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

/**
 ?appid=fa50bf80f3aba874aca0a2ad48316afa
 &mode=json
 &units=metric
 &lang=zh_tw
 &id=1819729
 */
final class EBWeatherForCityIDRequest: EBBaseRequest {
    let method = EBRequestMethod.GET
    let url = EBURLConstants.OpenWeather.GetWeatherForCityID
    let parameters: [String: String]

    init(applicationID: String = EBRequestConstants.Value.ApplicationID,
         temperatureFormat: EBRequestTemperatureFormat = .celsius,
         language: EBRequestLanguage = .english,
         cityID: String) {
        var parameters: [String: String] = [:]

        if !applicationID.isEmpty {
            parameters[EBRequestConstants.Key.ApplicationID] = applicationID
        }

        parameters[EBRequestConstants.Key.ResponseFormat] = EBRequestConstants.Value.Json

        if !temperatureFormat.rawValue.isEmpty {
            parameters[EBRequestConstants.Key.TemperatureFormat] = temperatureFormat.rawValue
        }

        if !language.rawValue.isEmpty {
            parameters[EBRequestConstants.Key.Language] = language.rawValue
        }

        if !cityID.isEmpty {
            parameters[EBRequestConstants.Key.CityID] = cityID
        }
        
        self.parameters = parameters
    }
}
