//
//  SharedSequenceConvertibleType+Rx.swift
//  AA
//
//  Created by Chris So on 28/12/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

public extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
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
