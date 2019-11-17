//
//  EBWeatherListViewModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBWeatherListViewModel: ViewModelType {
    struct Input {
        let triggerSetting: Driver<Void>
        let triggerRefresh: Driver<Void>
        let triggerAdd: Driver<Void>
        let triggerItemSelected: Driver<Int>
        let triggerItemDeleted: Driver<Int>
    }

    struct Output {
        let state: Driver<RxState>
        let headerViewModel: Driver<EBWeatherListHeaderViewModel>
        let cellModels: Driver<[EBWeatherListItemCellModel]>
    }

    private let navigator: EBWeatherListNavigator
    private let disposeBag = DisposeBag()
    private let stateTracker = RxStateTracker()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(navigator: EBWeatherListNavigator) {
        self.navigator = navigator
    }

    func transform(_ input: Input) -> Output {
        // Internal
        // Get weather report from location
        let weatherReportRelay = BehaviorRelay<EBWeatherReportModel>(value: EBWeatherReportModel())
        let weatherReport = weatherReportRelay.asDriver()

        // Get weather reports from preference
        let weatherReportsRelay = EBPreferenceManager.shared.weatherReportsRelay
        let weatherReports = weatherReportsRelay.asDriver()
        let cityIDs = weatherReports
            .map { weatherReports in
                weatherReports.map { weatherReport in
                    weatherReport.cityID
                }
            }
            .distinctUntilChanged()

        // Input
        input.triggerSetting
            .drive(onNext: navigator.showSetting)
            .disposed(by: disposeBag)

        input.triggerAdd
            .drive(onNext: navigator.showWeatherSearch)
            .disposed(by: disposeBag)

        input.triggerItemSelected
            .withLatestFrom(weatherReports) { index, weatherReports in
                weatherReports[index]
            }
            .drive(onNext: navigator.showWeatherDetail)
            .disposed(by: disposeBag)
        
        input.triggerItemDeleted
            .drive(onNext: EBPreferenceManager.shared.removeWeatherReport)
            .disposed(by: disposeBag)

        // Output
        let state = stateTracker.asDriver()

        EBLocationManager.shared.authorizationStatus
            .filter { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .mapToVoid()
            .drive(onNext: EBLocationManager.shared.startUpdatingLocation)
            .disposed(by: disposeBag)

        EBLocationManager.shared.authorizationStatus
            .filter { $0 != .authorizedAlways && $0 != .authorizedWhenInUse }
            .mapToVoid()
            .map { EBWeatherReportModel() }
            .drive(weatherReportRelay)
            .disposed(by: disposeBag)

        EBLocationManager.shared.location
            .throttle(.milliseconds(30000))
            .map { ($0.latitude, $0.longitude) }
            .flatMapLatest(_requestWeatherReport)
            .drive(weatherReportRelay)
            .disposed(by: disposeBag)

        // Model -> HeaderViewModel
        let headerViewModel = weatherReport
            .map(EBWeatherListHeaderViewModel.init)

        // Request & update weather reports on preference change / refresh
        Driver.combineLatest(cityIDs, input.triggerRefresh)
            .withLatestFrom(cityIDs)
            .flatMapLatest(_requestWeatherReports)
            .drive(weatherReportsRelay)
            .disposed(by: disposeBag)

        // Models -> CellModels
        let cellModels = weatherReports
            .map { $0.map(EBWeatherListItemCellModel.init) }

        return Output(state: state,
                      headerViewModel: headerViewModel,
                      cellModels: cellModels)
    }
}

// MARK: - Request

private extension EBWeatherListViewModel {
    private func _requestWeatherReports(cityIDs: [String]) -> Driver<[EBWeatherReportModel]> {
        let requestLanguage = EBRequestLanguage(Localize.currentLanguageCode)
        let request = EBWeatherForCityIDsRequest(language: requestLanguage,
                                                 cityIDs: cityIDs)
        let observable: Observable<EBMessageModel<EBWeatherReportModel>> = EBJsonClient.send(request)
        return observable
            .trackActivityState(stateTracker)
            .map { $0.list }
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: [])
    }

    private func _requestWeatherReport(latitude: Double, longitude: Double) -> Driver<EBWeatherReportModel> {
        let requestLanguage = EBRequestLanguage(Localize.currentLanguageCode)
        let request = EBWeatherForLocationRequest(language: requestLanguage,
                                                  latitude: latitude,
                                                  longitude: longitude)
        let observable: Observable<EBWeatherReportModel> = EBJsonClient.send(request)
        return observable
            .trackActivityState(stateTracker)
            .filter { $0.isValid }
            .asDriver(onErrorJustReturn: EBWeatherReportModel())
    }
}
