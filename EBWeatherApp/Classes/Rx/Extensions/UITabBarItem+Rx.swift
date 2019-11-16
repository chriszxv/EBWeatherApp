//
//  UITabBarItem+RX.swift
//  AA
//
//  Created by Chris So on 8/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observer

public extension Reactive where Base: UITabBarItem {
    /// Bindable sink for `badgeValue` property.
    var title: Binder<String?> {
        return Binder(base) { tabBarItem, title in
            tabBarItem.title = title
        }
    }
}
