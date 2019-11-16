//
//  Reusable.swift
//  AA
//
//  Created by Chris So on 1/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

public protocol ViewReusable {}

public extension ViewReusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ViewReusable {}

extension UICollectionReusableView: ViewReusable {}
