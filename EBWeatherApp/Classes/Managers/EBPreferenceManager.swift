//
//  EBPreferenceManager.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBPreferenceManager {
    static let shared = EBPreferenceManager()
    private let disposeBag = DisposeBag()

    let weatherReportsRelay: BehaviorRelay<[EBWeatherReportModel]>

    private init() {
        let userDefaults = UserDefaults.standard

        // Weather Reports
        if let array = userDefaults.object(forKey: EBPreferenceConstants.UserDefaults.Key.WeatherReports) as? [[String: Any]],
            let jsonData = try? JSONSerialization.data(withJSONObject: array, options: []),
            let models = try? JSONDecoder().decode([EBWeatherReportModel].self, from: jsonData) {
            weatherReportsRelay = BehaviorRelay(value: models)
        } else {
            weatherReportsRelay = BehaviorRelay(value: [])
        }
        _setupBindings()
    }

    private func _setupBindings() {
        _bindRelays()
    }

    private func _bindRelays() {
        // Weather Reports
        weatherReportsRelay
            .asDriver()
            .drive(onNext: { models in
                var array: [[String: Any]] = []
                for model in models {
                    guard let dictionary = model.toDictionary() else { return }
                    array.append(dictionary)
                }
                UserDefaults.standard.set(array, forKey: EBPreferenceConstants.UserDefaults.Key.WeatherReports)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Property

extension EBPreferenceManager {
    // MARK: Weather Reports

    func appendWeatherReport(newWeatherReport: EBWeatherReportModel) {
        let weatherReports = weatherReportsRelay.value
        for weatherReport in weatherReports {
            if weatherReport.cityID == newWeatherReport.cityID {
                return
            }
        }
        weatherReportsRelay.append(newWeatherReport)
    }

    func removeWeatherReport(at index: Int) {
        if index >= weatherReportsRelay.value.count {
            return
        }
        weatherReportsRelay.remove(at: index)
    }
}
