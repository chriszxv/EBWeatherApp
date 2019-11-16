//
//  UIView+Rx.swift
//  AA
//
//  Created by Chris So on 30/5/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UIView {
    /// Reactive wrapper for setter `isHidden`
    var onHidden: Observable<Bool> {
        return methodInvoked(#selector(setter: base.isHidden))
            .map { event -> Bool in
                guard let isHidden = event.first as? Bool else { fatalError() }
                return isHidden
            }
            .startWith(base.isHidden)
    }
}

// MARK: - Observer

public extension Reactive where Base: UIView {
    /// Bindable sink for `backgroundColor` property
    var backgroundColor: Binder<UIColor?> {
        return Binder(base) { view, backgroundColor in
            view.backgroundColor = backgroundColor
        }
    }

    /// Bindable sink for `borderColor` property
    var borderColor: Binder<UIColor?> {
        return Binder(base) { view, borderColor in
            view.borderColor = borderColor
        }
    }

    /// Bindable sink for `borderColor` property
    var borderWidth: Binder<CGFloat> {
        return Binder(base) { view, borderWidth in
            view.borderWidth = borderWidth
        }
    }

    /// Bindable sink for `cornerRadius` property
    var cornerRadius: Binder<CGFloat> {
        return Binder(base) { view, cornerRadius in
            view.cornerRadius = cornerRadius
        }
    }
}
