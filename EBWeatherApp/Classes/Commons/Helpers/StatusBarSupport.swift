//
//  StatusBarSupport.swift
//  AA
//
//  Created by Chris So on 7/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

// MARK: - Navigation Controller

extension UINavigationController {
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return topViewController?.preferredStatusBarUpdateAnimation ?? .none
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
}

// MARK: - Tab Bar Controller

extension UITabBarController {
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return children.first?.preferredStatusBarUpdateAnimation ?? .none
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return children.first?.preferredStatusBarStyle ?? .default
    }

    open override var childForStatusBarStyle: UIViewController? {
        return children.first
    }

    open override var childForStatusBarHidden: UIViewController? {
        return children.first
    }
}
