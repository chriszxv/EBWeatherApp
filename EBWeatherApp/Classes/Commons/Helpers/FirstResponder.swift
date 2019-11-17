//
//  FirstResponder.swift
//  AA
//
//  Created by Chris So on 26/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

// Find First Responder Recursively
extension UIResponder {
    public static var firstResponder: UIResponder? {
        let windows = UIApplication.shared.windows
        for window in windows {
            if window.isFirstResponder {
                return window
            }
            if let rootViewController = window.rootViewController {
                if let firstResponder = rootViewController.firstResponder {
                    return firstResponder
                }
            }
        }
        return nil
    }
}

extension UIViewController {
    var firstResponder: UIResponder? {
        if isFirstResponder {
            return self
        }
        if let firstResponder = self.view.firstResponder {
            return firstResponder
        }
        if let presentedViewController = presentedViewController,
            let firstResponder = presentedViewController.firstResponder {
            return firstResponder
        }
        if let presentingViewController = presentingViewController,
            let firstResponder = presentingViewController.firstResponder {
            return firstResponder
        }
        for viewController in children {
            if let responder = viewController.firstResponder {
                return responder
            }
        }
        return nil
    }
}

extension UIView {
    var firstResponder: UIResponder? {
        if isFirstResponder {
            return self
        }
        for view in subviews {
            if let responder = view.firstResponder {
                return responder
            }
        }
        return nil
    }
}
