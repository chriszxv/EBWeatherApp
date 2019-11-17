//
//  UINavigationBar.swift
//  AA
//
//  Created by Chris So on 11/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observer

public extension Reactive where Base: UINavigationBar {
    /// Bindable sink for `isTranslucent` property
    var isTranslucent: Binder<Bool> {
        return Binder(base) { view, attr in
            view.isTranslucent = attr
        }
    }

    /// Bindable sink for `backIndicatorImage` property
    var backIndicatorImage: Binder<UIImage> {
        return Binder(base) { view, attr in
            view.backIndicatorImage = attr
        }
    }

    /// Bindable sink for `backIndicatorTransitionMaskImage` property
    var backIndicatorTransitionMaskImage: Binder<UIImage> {
        return Binder(base) { view, attr in
            view.backIndicatorTransitionMaskImage = attr
        }
    }
}
