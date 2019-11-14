//
//  OrientationsSupport.swift
//  AA
//
//  Created by Chris So on 3/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

// MARK: - Navigation Controller

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        return visibleViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return visibleViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return visibleViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}

// MARK: - Tab Bar Controller

extension UITabBarController {
    open override var shouldAutorotate: Bool {
        return selectedViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return selectedViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}
