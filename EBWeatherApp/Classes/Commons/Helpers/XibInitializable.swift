//
//  XibInitializable.swift
//  AA
//
//  Created by Chris So on 2/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

public protocol XibInitializable {}

public extension XibInitializable where Self: UIView {
    static func instantiateFromXib() -> Self {
        let bundle = Bundle(for: self)
        return instantiateFromXib(bundle: bundle)
    }

    static func instantiateFromXib(bundle: Bundle?) -> Self {
        let type = Mirror(reflecting: self).subjectType
        let name = String(describing: type).components(separatedBy: ".")[0]
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! Self
        return view
    }
}

extension UIViewController: XibInitializable {}

extension UIView: XibInitializable {}
