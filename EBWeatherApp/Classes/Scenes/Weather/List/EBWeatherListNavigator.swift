//
//  EBWeatherListNavigator.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

final class EBWeatherListNavigator {
    private weak var rootNavigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        rootNavigationController = navigationController
    }

    func showSetting() {
        let viewController = EBSettingRootViewController.instantiateFromStoryboard()
        let navigator = EBSettingRootNavigator(viewController: viewController)
        let viewModel = EBSettingRootViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        rootNavigationController.present(viewController, animated: true)
    }

    func showWeatherSearch() {
        let navigationController = EBClearNavigationController()
        let viewController = EBWeatherSearchViewController.instantiateFromStoryboard()
        let navigator = EBWeatherSearchNavigator(navigationController: navigationController)
        let viewModel = EBWeatherSearchViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        rootNavigationController.present(navigationController, animated: true)
    }

    func showWeatherDetail(weatherReport: EBWeatherReportModel) {
        let viewController = EBWeatherDetailViewController.instantiateFromStoryboard()
        let navigator = EBWeatherDetailNavigator(navigationController: rootNavigationController)
        let viewModel = EBWeatherDetailViewModel(navigator: navigator, weatherReport: weatherReport)
        viewController.viewModel = viewModel
        rootNavigationController.pushViewController(viewController, animated: true)
    }
}
