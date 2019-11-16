//
//  EBWeatherForCityIDsRequest.swift
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
 &id=524901,1819729
 */
final class EBWeatherForCityIDsRequest: EBBaseRequest {
    let method = EBRequestMethod.GET
    let url = EBURLConstants.OpenWeather.Url.GetWeatherForcast
    let parameters: [String: String]

    init(applicationID: String = EBRequestConstants.Key.ApplicationID,
         temperatureFormat: EBRequestTemperatureFormat = .celsius,
         language: EBRequestLanguage = .english,
         cityIDs: [String]) {
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

        if !cityIDs.isEmpty {
            parameters[EBRequestConstants.Key.CityID] = cityIDs.joined(separator: ",")
        }
        self.parameters = parameters
    }
}
