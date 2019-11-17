//
//  EBTemperatureInfoViewModel.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBTemperatureInfoViewModel {
    let temperature: String
    let weatherImageKey: String?
    let weatherHighlightedImageKey: String?
    let isValid: Bool

    init(weatherReport: EBWeatherReportModel) {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        temperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.temperature, unit: .celsius))
        let weather = weatherReport.firstWeather
        weatherImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey)
        weatherHighlightedImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey, isFilled: true)

        isValid = weatherReport.isValid
    }
}
