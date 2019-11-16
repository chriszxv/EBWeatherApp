//
//  UIViewController+Rx.swift
//  AA
//
//  Created by Chris So on 30/5/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UIViewController {
    /// Reactive wrapper for `viewDidLoad`
    var viewDidLoad: Observable<Void> {
        return sentMessage(#selector(Base.viewDidLoad))
            .map { _ in }
    }

    /// Reactive wrapper for `viewWillAppear`
    var viewWillAppear: Observable<Bool> {
        return sentMessage(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }

    /// Reactive wrapper for `viewDidAppear`
    var viewDidAppear: Observable<Bool> {
        return sentMessage(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }

    /// Reactive wrapper for `viewWillDisappear`
    var viewWillDisappear: Observable<Bool> {
        return sentMessage(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }

    /// Reactive wrapper for `viewDidDisappear`
    var viewDidDisappear: Observable<Bool> {
        return sentMessage(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }

    /// Reactive wrapper for `viewWillLayoutSubviews`
    var viewWillLayoutSubviews: Observable<Void> {
        return sentMessage(#selector(Base.viewWillLayoutSubviews))
            .map { _ in }
    }

    /// Reactive wrapper for `viewDidLayoutSubviews`
    var viewDidLayoutSubviews: Observable<Void> {
        return sentMessage(#selector(Base.viewDidLayoutSubviews))
            .map { _ in }
    }
}

// MARK: - Observer

public extension Reactive where Base: UIViewController {
    /// Bindable sink for `title` property
    var title: Binder<String?> {
        return Binder(base) { viewController, title in
            viewController.title = title
        }
    }
}
