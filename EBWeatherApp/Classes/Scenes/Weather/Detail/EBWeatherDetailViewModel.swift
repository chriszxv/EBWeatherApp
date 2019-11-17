//
//  EBWeatherDetailViewModel.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBWeatherDetailViewModel: ViewModelType {
    struct Input {
        let triggerRefresh: Driver<Void>
    }

    struct Output {
        let state: Driver<RxState>
        let cityInfoViewModel: Driver<EBCityInfoViewModel>
        let temperatureInfoViewModel: Driver<EBTemperatureInfoViewModel>
        let minMaxTemperatureInfoViewModel: Driver<EBMinMaxTemperatureInfoViewModel>
        let windHumidityInfoViewModel: Driver<EBWindHumidityInfoViewModel>
    }

    private let navigator: EBWeatherDetailNavigator
    private let weatherReport: EBWeatherReportModel

    private let disposeBag = DisposeBag()
    private let stateTracker = RxStateTracker()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(navigator: EBWeatherDetailNavigator, weatherReport: EBWeatherReportModel) {
        self.navigator = navigator
        self.weatherReport = weatherReport
    }

    func transform(_ input: Input) -> Output {
        // Internal

        let weatherReportRelay = BehaviorRelay<EBWeatherReportModel>(value: weatherReport)
        let weatherReport = weatherReportRelay.asDriver()

        // Input

        input.triggerRefresh
            .withLatestFrom(weatherReport)
            .map { $0.cityID }
            .flatMapLatest(_requestWeatherReport)
            .drive(weatherReportRelay)
            .disposed(by: disposeBag)

        // Output
        let state = stateTracker.asDriver()

        // Models -> ViewModels
        let cityInfoViewModel = weatherReport.map(EBCityInfoViewModel.init)
        let temperatureInfoViewModel = weatherReport.map(EBTemperatureInfoViewModel.init)
        let minMaxTemperatureInfoViewModel = weatherReport.map(EBMinMaxTemperatureInfoViewModel.init)
        let windHumidityInfoViewModel = weatherReport.map(EBWindHumidityInfoViewModel.init)

        return Output(state: state,
                      cityInfoViewModel: cityInfoViewModel,
                      temperatureInfoViewModel: temperatureInfoViewModel,
                      minMaxTemperatureInfoViewModel: minMaxTemperatureInfoViewModel,
                      windHumidityInfoViewModel: windHumidityInfoViewModel)
    }
}

// MARK: - Request

private extension EBWeatherDetailViewModel {
    private func _requestWeatherReport(cityID: String) -> Driver<EBWeatherReportModel> {
        let requestLanguage = EBRequestLanguage(Localize.currentLanguageCode)
        let request = EBWeatherForCityIDRequest(language: requestLanguage,
                                                cityID: cityID)
        let observable: Observable<EBWeatherReportModel> = EBJsonClient.send(request)
        return observable
            .trackActivityState(stateTracker)
            .filter { $0.isValid }
            .asDriver(onErrorJustReturn: EBWeatherReportModel())
    }
}
