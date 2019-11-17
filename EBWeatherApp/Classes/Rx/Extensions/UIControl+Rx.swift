//
//  UIControl+Rx.swift
//  AA
//
//  Created by Atkins Leung on 5/7/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

extension Reactive where Base: UIControl {
    /// Reactive wrapper for setter `isSelected`
    public var onSelected: Observable<Bool> {
        return methodInvoked(#selector(setter: base.isSelected))
            .map { event -> Bool in
                guard let isSelected = event.first as? Bool else { fatalError() }
                return isSelected
            }
            .startWith(base.isSelected)
    }

    /// Reactive wrapper for setter `isHighlighted`
    public var onHighlighted: Observable<Bool> {
        return methodInvoked(#selector(setter: base.isHighlighted))
            .map { event -> Bool in
                guard let isHighlighted = event.first as? Bool else { fatalError() }
                return isHighlighted
            }
            .startWith(base.isHighlighted)
    }
}

// MARK: - Observer

extension Reactive where Base: UIControl {
    /// Bindable sink for `highlighted` property.
    public var isHighlighted: Binder<Bool> {
        return Binder(base) { control, highlighted in
            control.isHighlighted = highlighted
        }
    }
}
