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
        // Start up states
        _ = EBPreferenceManager.shared
    }

    private func _setupUIs() {
        // None
    }

    private func _setupBindings() {
        _bindLocaleService()
        _bindUIs()
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
    func configureMainInterface() -> UINavigationController {
        let navigationController = EBClearNavigationController()
        let viewController = EBWeatherListViewController.instantiateFromStoryboard()
        let navigator = EBWeatherListNavigator(navigationController: navigationController)
        let viewModel = EBWeatherListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
}
