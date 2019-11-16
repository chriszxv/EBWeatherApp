//
//  RxStateTracker.swift
//  AA
//
//  Created by Chris So on 5/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

public enum RxState: UInt {
    case onInitialize
    case onNext
    case onError
    case onCompleted
    case onSubscribe
    case onSubscribed
    case onDispose
}

public class RxStateTracker: SharedSequenceConvertibleType {
    public typealias Element = RxState
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _stateRelay = BehaviorRelay<RxState>(value: .onInitialize)

    public init() {
        // None
    }

    fileprivate func trackActivityStateOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendOnNext()
            }, onError: { _ in
                self.sendOnError()
            }, onCompleted: {
                self.sendOnCompleted()
            }, onSubscribe: {
                self.sendOnSubscribe()
            }, onSubscribed: {
                self.sendOnSubscribed()
            }, onDispose: {
                self.sendOnDispose()
            })
    }

    private func sendOnNext() {
        _lock.lock()
        _stateRelay.accept(.onNext)
        _lock.unlock()
    }

    private func sendOnError() {
        _lock.lock()
        _stateRelay.accept(.onError)
        _lock.unlock()
    }

    private func sendOnCompleted() {
        _lock.lock()
        _stateRelay.accept(.onCompleted)
        _lock.unlock()
    }

    private func sendOnSubscribe() {
        _lock.lock()
        _stateRelay.accept(.onSubscribe)
        _lock.unlock()
    }

    private func sendOnSubscribed() {
        _lock.lock()
        _stateRelay.accept(.onSubscribed)
        _lock.unlock()
    }

    private func sendOnDispose() {
        _lock.lock()
        _stateRelay.accept(.onDispose)
        _lock.unlock()
    }

    // Make asDriver work as listening stateRelay itself
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _stateRelay.asDriver()
            .distinctUntilChanged()
    }
}

public extension ObservableConvertibleType {
    func trackActivityState(_ tracker: RxStateTracker) -> Observable<Element> {
        return tracker.trackActivityStateOfObservable(self)
    }
}
