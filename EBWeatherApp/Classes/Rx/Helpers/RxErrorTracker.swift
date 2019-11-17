//
//  RxErrorTracker.swift
//  AA
//
//  Created by Chris So on 8/7/2019.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

public class RxErrorTracker: SharedSequenceConvertibleType {
    public typealias Element = Error
    public typealias SharingStrategy = SignalSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _errorRelay = PublishRelay<Error>()

    public init() {
        // None
    }

    fileprivate func trackActivityErrorOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return source.asObservable()
            .do(onError: { error in
                self.sendOnError(error)
            })
    }

    private func sendOnError(_ error: Error) {
        _lock.lock()
        _errorRelay.accept(error)
        _lock.unlock()
    }

    // Make asDriver work as listening stateRelay itself
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _errorRelay.asSignal()
    }
}

public extension ObservableConvertibleType {
    func trackActivityError(_ tracker: RxErrorTracker) -> Observable<Element> {
        return tracker.trackActivityErrorOfObservable(self)
    }
}
