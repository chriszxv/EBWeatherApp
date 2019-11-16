//
//  EBWeatherForCityNameRequest.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

/**
 ?appid=fa50bf80f3aba874aca0a2ad48316afa
 &mode=json
 &units=metric
 &lang=zh_tw
 &q=hong%20kong
 */
final class EBWeatherForCityNameRequest: EBBaseRequest {
    let method = EBRequestMethod.GET
    let url = EBURLConstants.OpenWeather.Url.GetWeatherForcast
    let parameters: [String: String]

    init(applicationID: String = EBRequestConstants.Key.ApplicationID,
         temperatureFormat: EBRequestTemperatureFormat = .celsius,
         language: EBRequestLanguage = .english,
         cityName: String) {
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

        if !cityName.isEmpty {
            parameters[EBRequestConstants.Key.CityName] = cityName
        }
        self.parameters = parameters
    }
}
