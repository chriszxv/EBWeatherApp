//
//  EBAppManager.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBAppManager {
    public static let shared = EBAppManager()

    private let disposeBag = DisposeBag()

    private init() {
        _setupMonitoringRxResource()
        _setupStates()
        _setupUIs()
        _setupBindings()
    }

    private func _setupMonitoringRxResource() {
        #if DEBUG
            // Check memory leak
            Observable<Int>.interval(.milliseconds(1000), scheduler: MainScheduler.instance)
                .subscribe(onNext: { _ in
                    print("Rx resource: \(RxSwift.Resources.total)")
                }).disposed(by: disposeBag)
        #endif
    }

    private func _setupStates() {
//        _ = EBPreferenceManager.shared
    }

    private func _setupUIs() {
        // None
    }

    private func _setupBindings() {
        _bindThemeService()
        _bindLocaleService()
        _bindUIs()
    }

    private func _bindThemeService() {
        // None
    }

    private func _bindLocaleService() {
        Localize.setup()
    }

    private func _bindUIs() {
        // None
    }
}

// MARK: - Interface

extension EBAppManager {
    func configureMainInterface() -> UIViewController {
        let viewController = EBWeatherListViewController.instantiateFromStoryboard()
        let navigator = EBWeatherListNavigator(viewController: viewController)
        let viewModel = EBWeatherListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
