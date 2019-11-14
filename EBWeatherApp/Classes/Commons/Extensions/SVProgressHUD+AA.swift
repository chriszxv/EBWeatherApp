//
//  SVProgressHUD+AA.swift
//  AA
//
//  Created by Chris So on 5/8/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    static func show(isUserInteractionEnabled: Bool) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setBackgroundLayerColor(.clear)
        if isUserInteractionEnabled {
            SVProgressHUD.setDefaultMaskType(.none)
        } else {
            SVProgressHUD.setDefaultMaskType(.custom)
        }
        SVProgressHUD.show()
    }
}
