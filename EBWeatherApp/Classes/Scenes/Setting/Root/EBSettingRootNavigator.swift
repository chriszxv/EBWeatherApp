//
//  EBSettingRootNavigator.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

final class EBSettingRootNavigator {
    private weak var rootViewController: UIViewController!

    init(viewController: UIViewController) {
        rootViewController = viewController
    }

    func dismiss() {
        rootViewController.dismiss(animated: true)
    }

    func showExternal(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
