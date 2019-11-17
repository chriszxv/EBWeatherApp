//
//  EBTextField.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

class EBTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }

    @IBInspectable var insetY: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
