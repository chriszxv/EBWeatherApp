//
//  StoryboardInitializable.swift
//  AA
//
//  Created by Chris So on 2/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

public protocol StoryboardInitializable {}

public extension StoryboardInitializable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func instantiateFromStoryboard() -> Self {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }

    static func instantiateFromStoryboard(name: String = "Main") -> Self {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }

    static func instantiateFromStoryboard(name: String = "Main", identifier: String) -> Self {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }

    static func instantiateFromStoryboard(name: String = "Main", bundle: Bundle?, identifier: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

public extension UIViewController {
    @objc dynamic class var storyboardName: String {
        return "Main"
    }
}

extension UIViewController: StoryboardInitializable {}
