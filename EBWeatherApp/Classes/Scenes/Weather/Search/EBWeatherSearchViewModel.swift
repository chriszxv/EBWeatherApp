//
//  EBWeatherSearchViewModel.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBWeatherSearchViewModel: ViewModelType {
    struct Input {
        let triggerLocation: Driver<Void>
        let triggerClose: Driver<Void>
        let triggerSearch: Driver<String>
        let triggerRefresh: Driver<Void>
        let triggerItemSelected: Driver<Int>
    }

    struct Output {
        let state: Driver<RxState>
        let isGettingLocation: Driver<Bool>
        let cellModels: Driver<[EBWeatherSearchItemCellModel]>
    }

    private let navigator: EBWeatherSearchNavigator
    private let disposeBag = DisposeBag()
    private let stateTracker = RxStateTracker()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(navigator: EBWeatherSearchNavigator) {
        self.navigator = navigator
    }

    func transform(_ input: Input) -> Output {
        // Internal
        let keywordRelay = BehaviorRelay<String>(value: "")
        let keyword = keywordRelay.asDriver()

        let weatherReportsRelay = BehaviorRelay<[EBWeatherReportModel]>(value: [])
        let weatherReports = weatherReportsRelay.asDriver()

        // Input
        let authorizationStatus = EBLocationManager.shared.authorizationStatus

        input.triggerLocation
            .withLatestFrom(authorizationStatus)
            .filter { $0 != .denied && $0 != .restricted }
            .mapToVoid()
            .drive(onNext: EBLocationManager.shared.startUpdatingLocation)
            .disposed(by: disposeBag)

        input.triggerLocation
            .withLatestFrom(authorizationStatus)
            .filter { $0 == .denied || $0 == .restricted }
            .mapToVoid()
            .drive(onNext: navigator.showLocationPermissionAlert)
            .disposed(by: disposeBag)

        input.triggerClose
            .drive(onNext: navigator.dismiss)
            .disposed(by: disposeBag)

        input.triggerSearch
            .debounce(.milliseconds(500))
            .drive(keywordRelay)
            .disposed(by: disposeBag)

        let modelSelected = input.triggerItemSelected
            .withLatestFrom(weatherReports) { index, weatherReports in
                weatherReports[index]
            }

        modelSelected
            .filter { !$0.isValid }
            .mapToVoid()
            .drive(onNext: navigator.showInvalidCityAlert)
            .disposed(by: disposeBag)

        modelSelected
            .filter { $0.isValid }
            .drive(onNext: EBPreferenceManager.shared.appendWeatherReport)
            .disposed(by: disposeBag)

        modelSelected
            .filter { $0.isValid }
            .mapToVoid()
            .drive(onNext: navigator.dismiss)
            .disposed(by: disposeBag)

        // Output
        let state = stateTracker.asDriver()

        let isGettingLocation = authorizationStatus
            .map { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }

        // Request & update weather reports on keyword change / refresh
        Driver.combineLatest(keyword, input.triggerRefresh)
            .withLatestFrom(keyword)
            .filter { !$0.isEmpty }
            .flatMapLatest(_requestWeatherReports(keyword:))
            .drive(weatherReportsRelay)
            .disposed(by: disposeBag)

        // Models -> CellModels
        let cellModels = weatherReports
            .map { $0.map(EBWeatherSearchItemCellModel.init) }

        return Output(state: state,
                      isGettingLocation: isGettingLocation,
                      cellModels: cellModels)
    }
}

// MARK: - Request

private extension EBWeatherSearchViewModel {
    private func _requestWeatherReports(keyword: String) -> Driver<[EBWeatherReportModel]> {
        if let firstGroup = keyword.components(separatedBy: ",").first,
            firstGroup.isNumeric() {
            return _requestWeatherReports(zipCode: keyword)
        } else {
            return _requestWeatherReports(cityName: keyword)
        }
    }

    private func _requestWeatherReports(cityName: String) -> Driver<[EBWeatherReportModel]> {
        let requestLanguage = EBRequestLanguage(Localize.currentLanguageCode)
        let request = EBWeatherForCityNameRequest(language: requestLanguage,
                                                  cityName: cityName)
        let observable: Observable<EBMessageModel<EBWeatherReportModel>> = EBJsonClient.send(request)
        return observable
            .trackActivityState(stateTracker)
            .map { $0.list }
            .asDriver(onErrorJustReturn: [])
    }

    private func _requestWeatherReports(zipCode: String) -> Driver<[EBWeatherReportModel]> {
        let requestLanguage = EBRequestLanguage(Localize.currentLanguageCode)
        let request = EBWeatherForZipCodeRequest(language: requestLanguage,
                                                 zipCode: zipCode)
        let observable: Observable<EBWeatherReportModel> = EBJsonClient.send(request)
        return observable
            .trackActivityState(stateTracker)
            .map { [$0] }
            .asDriver(onErrorJustReturn: [])
    }
}
