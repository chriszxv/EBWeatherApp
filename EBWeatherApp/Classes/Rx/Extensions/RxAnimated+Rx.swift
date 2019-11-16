//
//  RxAnimated+Rx.swift
//  AA
//
//  Created by Chris So on 12/3/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxAnimated
import RxCocoa
import RxSwift

extension AnimatedSink where Base: UIView {
    /// cross-dissolve animation on `UIView`
    public func fade() -> AnimatedSink<Base> {
        return fade(duration: 0.33)
    }

    /// auto layout animations on `UIView`
    public func layout(duration: TimeInterval) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: RxAnimationType.animation, duration: duration, animations: { view in
            view.layoutIfNeeded()
        })
        return AnimatedSink<Base>(base: base, type: type)
    }

    /// auto layout animations on `UIView`
    public func layout() -> AnimatedSink<Base> {
        return layout(duration: 0.33)
    }
}

extension AnimatedSink where Base: NSLayoutConstraint {
    /// auto layout animations
    public func layout() -> AnimatedSink<Base> {
        return layout(duration: 0.33)
    }
}
