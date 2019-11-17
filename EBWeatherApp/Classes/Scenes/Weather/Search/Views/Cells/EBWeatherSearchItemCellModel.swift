//
//  EBWeatherSearchItemCellModel.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBWeatherSearchItemCellModel {
    let cityName: String
    let cityCountryCode: String
    let temperature: String
    let weatherImageKey: String?
    let weatherHighlightedImageKey: String?
    init(weatherReport: EBWeatherReportModel) {
        cityName = weatherReport.cityName
        cityCountryCode = weatherReport.system.countryCode
        let measurement = Measurement<UnitTemperature>(value: weatherReport.temperature.temperature, unit: .celsius)
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        temperature = formatter.string(from: measurement)
        let weather = weatherReport.firstWeather
        weatherImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey)
        weatherHighlightedImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey, isFilled: true)
    }
}
