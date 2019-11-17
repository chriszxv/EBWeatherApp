//
//  ObservableType+Rx.swift
//  AA
//
//  Created by Chris So on 5/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    /**
     Dismiss errors and complete the sequence instead

     - returns: An observable sequence that never errors and completes when an error occurs in the underlying sequence
     */
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }

    func asDriverOnErrorDriveWithNever() -> Driver<Element> {
        return asDriver(onErrorDriveWith: .never())
    }

    func asSignalOnErrorJustComplete() -> Signal<Element> {
        return asSignal { _ in
            Signal.empty()
        }
    }

    func asSignalOnErrorDriveWithNever() -> Signal<Element> {
        return asSignal(onErrorSignalWith: .never())
    }
}

// MARK: - materialize -> elements, errors

public extension ObservableType where Element: EventConvertible {
    /**
     Returns an observable sequence containing only next elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    func elements() -> Observable<Element.Element> {
        return compactMap { $0.event.element }
    }

    /**
     Returns an observable sequence containing only error elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    func errors() -> Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}
