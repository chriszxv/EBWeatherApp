//
//  UISearchBar+AA.swift
//  AA
//
//  Created by Chris So on 24/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

public extension UISearchBar {
    var searchField: UITextField {
        if let searchField: UITextField = value(forKey: "searchField") as? UITextField {
            return searchField
        } else {
            return UITextField()
        }
    }
}
