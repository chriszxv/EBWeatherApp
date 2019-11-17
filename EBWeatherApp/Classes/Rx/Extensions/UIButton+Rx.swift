//
//  UIButton+Rx.swift
//  AA
//
//  Created by Atkins Leung on 12/7/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxAnimated
import RxCocoa
import RxSwift

// MARK: - Observer

public extension Reactive where Base: UIButton {
    /// Bindable sink for `titleColor` property
    func titleColor(for controlState: UIControl.State = []) -> Binder<UIColor?> {
        return Binder(base) { button, titleColor in
            button.setTitleColor(titleColor, for: controlState)
        }
    }
}

// MARK: - Animated Observer

public extension AnimatedSink where Base: UIButton {
    /// Bindable animated sink for `tintColor`
    var tintColor: Binder<UIColor> {
        return Binder(base) { button, tintColor in
            self.type.animate(view: button) {
                (button as UIButton).tintColor = tintColor
            }
        }
    }
}
