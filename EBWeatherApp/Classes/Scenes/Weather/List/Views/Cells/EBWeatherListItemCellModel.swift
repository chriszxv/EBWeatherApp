//
//  EBWeatherListItemCellModel.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBWeatherListItemCellModel {
    let cityName: String
    let date: String
    let temperature: String
    let weatherImageKey: String?
    let weatherHighlightedImageKey: String?

    init(weatherReport: EBWeatherReportModel) {
        cityName = weatherReport.cityName
        date = weatherReport.displayTime
        let measurement = Measurement<UnitTemperature>(value: weatherReport.temperature.temperature, unit: .celsius)
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        temperature = formatter.string(from: measurement.unit)
        let weather = weatherReport.firstWeather
        weatherImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey)
        weatherHighlightedImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey, isFilled: true)
    }
}
