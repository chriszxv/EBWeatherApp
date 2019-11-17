//
//  UIViewController+AA.swift
//  AA
//
//  Created by Chris So on 7/7/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

extension UIViewController {
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        window.rootViewController = viewController
        // Normal window level: 0
        // Status window level: 1000
        // Alert window level: 2000
        // Put the new window at the very top
        window.windowLevel = .alert + 1
        // display window by makes a window key,
        // and moves it to be in front of any other windows on its level.
        window.makeKeyAndVisible()
        viewController.present(self, animated: true)
    }

    func dismissAllPresentedViewControllers(completion: (() -> Void)? = nil) {
        if presentedViewController == nil {
            if let completion = completion {
                completion()
            }
            return
        }
        var viewController = presentedViewController
        var presentedViewControllers: [UIViewController] = []
        while let presentedViewController = viewController {
            presentedViewControllers.append(presentedViewController)
            viewController = viewController?.presentedViewController
        }
        UIViewController._dismissAllPresentedViewControllers(presentedViewControllers, completion: completion)
    }

    private static func _dismissAllPresentedViewControllers(_ presentedViewControllers: [UIViewController], completion: (() -> Void)? = nil) {
        guard let presentedViewController = presentedViewControllers.last else {
            if let completion = completion {
                completion()
            }
            return
        }
        var presentedViewControllers = presentedViewControllers
        presentedViewController.dismiss(animated: true) {
            _ = presentedViewControllers.popLast()
            _dismissAllPresentedViewControllers(presentedViewControllers, completion: completion)
        }
    }
}
