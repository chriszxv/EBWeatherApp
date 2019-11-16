//
//  UINavigationItem+Rx.swift
//  AA
//
//  Created by Chris So on 12/7/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observer

public extension Reactive where Base: UINavigationItem {
    /// Bindable sink for `hidesBackButton` property
    var hidesBackButton: Binder<Bool> {
        return Binder(base) { view, hidesBackButton in
            view.hidesBackButton = hidesBackButton
        }
    }
}
