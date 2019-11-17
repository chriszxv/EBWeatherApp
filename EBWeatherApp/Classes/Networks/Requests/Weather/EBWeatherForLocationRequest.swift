//
//  EBWeatherForLocationRequest.swift
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
 &lat=55.5
 &lon=37.5
 */
final class EBWeatherForLocationRequest: EBBaseRequest {
    let method = EBRequestMethod.GET
    let url = EBURLConstants.OpenWeather.GetWeatherForLocation
    let parameters: [String: String]

    init(applicationID: String = EBRequestConstants.Value.ApplicationID,
         temperatureFormat: EBRequestTemperatureFormat = .celsius,
         language: EBRequestLanguage = .english,
         latitude: Double,
         longitude: Double) {
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

        if !latitude.isNaN {
            parameters[EBRequestConstants.Key.Latitude] = String(latitude)
        }
        
        if !longitude.isNaN {
            parameters[EBRequestConstants.Key.Longitude] = String(longitude)
        }

        self.parameters = parameters
    }
}
