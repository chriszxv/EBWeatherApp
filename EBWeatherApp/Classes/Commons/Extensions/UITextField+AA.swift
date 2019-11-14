//
//  UITextField+AA.swift
//  AA
//
//  Created by Chris So on 3/9/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

@objc extension UITextField {
    override open var isEnabled: Bool {
        didSet {
            if isEnabled {
                alpha = 1
            } else {
                alpha = 0.4
            }
        }
    }
}
