//
//  UITabBarController+Rx.swift
//  AA
//
//  Created by Chris So on 19/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UITabBarController {
    /// Reactive wrapper for setter `selectedViewController`
    var selectedViewController: Observable<UIViewController?> {
        return methodInvoked(#selector(setter: base.selectedViewController))
            .map { event -> UIViewController in
                guard let selectedViewController = event.first as? UIViewController else { fatalError() }
                return selectedViewController
            }
            .startWith(base.selectedViewController)
    }

    /// Reactive wrapper for setter `selectedIndex`
    var selectedIndex: Observable<Int> {
        return methodInvoked(#selector(setter: base.selectedIndex))
            .map { event -> Int in
                guard let selectedIndex = event.first as? Int else { fatalError() }
                return selectedIndex
            }
            .startWith(base.selectedIndex)
    }
}
