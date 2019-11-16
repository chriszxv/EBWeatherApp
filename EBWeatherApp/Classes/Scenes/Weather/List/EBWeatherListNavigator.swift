//
//  EBWeatherListNavigator.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

final class EBWeatherListNavigator {
    private weak var rootViewController: UIViewController!

    init(viewController: UIViewController) {
        rootViewController = viewController
    }

    func showSetting() {
        let viewController = EBSettingRootViewController.instantiateFromStoryboard()
        let navigator = EBSettingRootNavigator(viewController: viewController)
        let viewModel = EBSettingRootViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        rootViewController.present(viewController, animated: true)
    }
}
