//
//  EBCityInfoViewModel.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import Foundation

struct EBCityInfoViewModel {
    let cityName: String
    let cityCountryCode: String
    let coordinate: String
    let date: String
    let isValid: Bool

    init(weatherReport: EBWeatherReportModel) {
        cityName = weatherReport.cityName
        cityCountryCode = weatherReport.system.countryCode
        coordinate = "(\(weatherReport.coordinate.latitude.clean), \(weatherReport.coordinate.longitude.clean))"
        date = weatherReport.displayDay
        isValid = weatherReport.isValid
    }
}
