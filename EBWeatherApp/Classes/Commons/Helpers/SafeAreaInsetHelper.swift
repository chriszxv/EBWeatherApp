//
//  SafeAreaInsetHelper.swift
//  AA
//
//  Created by Chris So on 5/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import UIKit

struct SafeAreaInsetHelper {
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets
        } else {
            return .zero
        }
    }
}
