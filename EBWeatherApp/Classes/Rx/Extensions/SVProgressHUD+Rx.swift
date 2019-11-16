//
//  SVProgressHUD+Rx.swift
//  AA
//
//  Created by Chris So on 9/7/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift
import SVProgressHUD

// MARK: - Observer

extension Reactive where Base: SVProgressHUD {
    static func isAnimating(isUserInteractionEnabled: Bool = true) -> Binder<Bool> {
        return Binder(UIApplication.shared) { _, isVisible in
            if isVisible {
                SVProgressHUD.show(isUserInteractionEnabled: isUserInteractionEnabled)
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }

    static func show(isUserInteractionEnabled: Bool = true) -> Binder<Void> {
        return Binder(UIApplication.shared) { _, _ in
            SVProgressHUD.show(isUserInteractionEnabled: isUserInteractionEnabled)
        }
    }

    static var dismiss: Binder<Void> {
        return Binder(UIApplication.shared) { _, _ in
            SVProgressHUD.dismiss()
        }
    }
}
