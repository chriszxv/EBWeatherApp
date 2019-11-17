//
//  UIPopoverPresentationController+Rx.swift
//  AA
//
//  Created by Chris So on 17/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observer

public extension Reactive where Base: UIPopoverPresentationController {
    /// Bindable sink for `backgroundColor` property
    var backgroundColor: Binder<UIColor?> {
        return Binder(base) { view, backgroundColor in
            view.backgroundColor = backgroundColor
        }
    }
}
