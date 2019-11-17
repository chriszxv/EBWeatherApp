//
//  Print.swift
//  AA
//
//  Created by Chris So on 16/5/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

// Override system print
// 1. Show with module name
// 2. Stop showing on release version
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let object = NSStringFromClass(BundleResource.self) as NSString
        let targetName = object.components(separatedBy: ".").first ?? ""
        items.forEach {
            Swift.print("[\(targetName)] \($0)", separator: separator, terminator: terminator)
        }
    #endif
}
