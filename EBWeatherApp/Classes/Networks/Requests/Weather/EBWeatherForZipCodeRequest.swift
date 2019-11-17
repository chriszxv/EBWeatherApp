//
//  EBWeatherForZipCodeRequest.swift
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
 &zip=94040,us
 */
final class EBWeatherForZipCodeRequest: EBBaseRequest {
    let method = EBRequestMethod.GET
    let url = EBURLConstants.OpenWeather.GetWeatherForZipCode
    let parameters: [String: String]

    init(applicationID: String = EBRequestConstants.Value.ApplicationID,
         temperatureFormat: EBRequestTemperatureFormat = .celsius,
         language: EBRequestLanguage = .english,
         zipCode: String) {
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

        if !zipCode.isEmpty {
            parameters[EBRequestConstants.Key.ZipCode] = zipCode
        }
        
        self.parameters = parameters
    }
}
