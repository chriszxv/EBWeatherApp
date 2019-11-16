//
//  BundleResource.swift
//  AA
//
//  Created by Chris So on 12/3/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

class BundleResource {
    public static func imageNamed(_ name: String) -> UIImage {
        let bundle = Bundle(for: self)
        return UIImage(named: name, in: bundle, compatibleWith: nil)!
    }
}

extension UIImage {
    public static func asset(_ name: String) -> UIImage {
        return BundleResource.imageNamed(name)
    }
}
