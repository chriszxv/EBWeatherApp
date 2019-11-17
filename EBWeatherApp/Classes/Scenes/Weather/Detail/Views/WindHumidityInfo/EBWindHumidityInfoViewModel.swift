//
//  EBWindHumidityInfoViewModel.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBWindHumidityInfoViewModel {
    let wind: String
    let humidity: String
    let isValid: Bool

    init(weatherReport: EBWeatherReportModel) {
        wind = "\(weatherReport.wind.speed)m/s, \(weatherReport.wind.degrees.clean)°"
        humidity = "\(weatherReport.temperature.humidity)%"
        isValid = weatherReport.isValid
    }
}
