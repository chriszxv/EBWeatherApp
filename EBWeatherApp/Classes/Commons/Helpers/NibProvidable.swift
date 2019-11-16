//
//  NibProvidable.swift
//  AA
//
//  Created by Chris So on 1/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

public protocol NibProvidable {}

public extension NibProvidable where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}

extension UITableViewCell: NibProvidable {}

extension UICollectionReusableView: NibProvidable {}
