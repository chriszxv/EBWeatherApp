//
//  EBMinMaxTemperatureInfoViewModel.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBMinMaxTemperatureInfoViewModel {
    let weatherCondition: String
    let minMaxTemperature: String
    let isValid: Bool

    init(weatherReport: EBWeatherReportModel) {
        weatherCondition = weatherReport.firstWeather.description
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        let mimimumTemperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.mimimumTemperature, unit: .celsius))
        let maximumTemperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.maximumTemperature, unit: .celsius))
        minMaxTemperature = "\(mimimumTemperature)-\(maximumTemperature)"
        isValid = weatherReport.isValid
    }
}
