//
//  EBWeatherSearchNavigator.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

final class EBWeatherSearchNavigator {
    private weak var rootNavigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        rootNavigationController = navigationController
    }

    func dismiss() {
        rootNavigationController.dismiss(animated: true)
    }

    func showInvalidCityAlert() {
        let alertController = UIAlertController(title: R.string.localizable.error_title_invalid_operation.key.localized,
                                                message: R.string.localizable.error_message_invalid_city.key.localized,
                                                preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: R.string.localizable.action_determine.key.localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.modalPresentationStyle = .overCurrentContext
        rootNavigationController.present(alertController, animated: true)
    }

    func showLocationPermissionAlert() {
        let alertController = UIAlertController(title: R.string.localizable.error_title_permission_location.key.localized,
                                                message: R.string.localizable.error_message_permission_location.key.localized,
                                                preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: R.string.localizable.action_cancel.key.localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let settingsAction = UIAlertAction(title: R.string.localizable.action_setting.key.localized, style: .default, handler: { _ in
            // Take the user to Settings app to possibly change permission.
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        alertController.addAction(settingsAction)
        alertController.modalPresentationStyle = .overCurrentContext
        rootNavigationController.present(alertController, animated: true)
    }
}
