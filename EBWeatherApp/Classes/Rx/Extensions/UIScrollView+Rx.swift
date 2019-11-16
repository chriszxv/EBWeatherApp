//
//  UIScrollView+Rx.swift
//  AA
//
//  Created by Chris So on 23/7/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UIScrollView {
    /// Reactive wrapper for `contentOffset`
    var isNearTop: Observable<Bool> {
        return contentOffset
            .map { $0.y < 100.0 ? true : false }
            .distinctUntilChanged()
    }

    /// Reactive wrapper for `contentOffset`
    var isNearBottom: Observable<Bool> {
        return contentOffset
            .map { [unowned base] in
                base.rx.isNearBottom(with: $0) ? true : false
            }
            .distinctUntilChanged()
    }

    func isNearBottom(with contentOffset: CGPoint) -> Bool {
        if base.contentSize.height <= base.frame.size.height {
            return false
        } else {
            return contentOffset.y + base.frame.size.height + 100.0 > base.contentSize.height
        }
    }

    var contentSize: Observable<CGSize> {
        return observe(CGSize.self, "contentSize")
            .map { $0 ?? CGSize.zero }
    }
}
