//
//  UITextField+Rx.swift
//  AA
//
//  Created by Chris So on 28/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UITextField {
    /// Reactive wrapper for `text` property whatever it changed.
    var textChanged: Observable<String> {
        return Observable.merge(base.rx.observe(String.self, "text"),
                                base.rx.controlEvent([.editingChanged]).withLatestFrom(base.rx.text))
            .distinctUntilChanged()
            .map { $0 ?? "" }
    }

    /// Reactive wrapper for `text` property while user end editing.
    var editingDidEnd: Observable<String> {
        return base.rx.controlEvent([.editingDidEnd])
            .withLatestFrom(base.rx.text)
            .map { $0 ?? "" }
    }
}

// MARK: - Observer

public extension Reactive where Base: UITextField {
    var placeholder: Binder<String?> {
        return Binder(base) { view, placeholder in
            view.placeholder = placeholder
        }
    }
}
