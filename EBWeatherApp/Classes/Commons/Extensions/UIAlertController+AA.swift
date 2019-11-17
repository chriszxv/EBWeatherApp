//
//  UIAlertController+AA.swift
//  AA
//
//  Created by Chris So on 17/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

extension UIAlertController {
    open override var shouldAutorotate: Bool {
        return false
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
