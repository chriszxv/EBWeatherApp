//
//  EBWeatherListHeaderViewModel.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBWeatherListHeaderViewModel {
    let cityName: String
    let cityCountryCode: String
    let temperature: String
    let weatherImageKey: String?
    let weatherHighlightedImageKey: String?
    let minMaxTemperature: String
    let wind: String
    let humidity: String
    let isValid: Bool

    init(weatherReport: EBWeatherReportModel) {
        cityName = weatherReport.cityName
        cityCountryCode = weatherReport.system.countryCode
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        temperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.temperature, unit: .celsius))
        let weather = weatherReport.firstWeather
        weatherImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey)
        weatherHighlightedImageKey = EBWeatherImageMapper.imageKey(for: weather.weatherID, weather.dayKey, isFilled: true)

        let mimimumTemperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.mimimumTemperature, unit: .celsius))
        let maximumTemperature = formatter.string(from: Measurement<UnitTemperature>(value: weatherReport.temperature.maximumTemperature, unit: .celsius))
        minMaxTemperature = "\(mimimumTemperature)-\(maximumTemperature)"
        wind = "\(weatherReport.wind.speed)m/s, \(weatherReport.wind.degrees.clean)°"
        humidity = "\(weatherReport.temperature.humidity)%"
        isValid = weatherReport.isValid
    }
}
