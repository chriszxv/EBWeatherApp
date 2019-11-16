//
//  BehaviorRelay+Rx.swift
//  AA
//
//  Created by Chris So on 20/12/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: RangeReplaceableCollection

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(_ newElement: Element.Element) {
        var newValue = value
        newValue.append(newElement)
        accept(newValue)
    }

    func append<S>(contentsOf newElements: S) where S: Sequence, Element.Element == S.Element {
        var newValue = value
        newValue.append(contentsOf: newElements)
        accept(newValue)
    }

    func insert(_ subElement: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(subElement, at: index)
        accept(newValue)
    }

    func insert(contentsOf newSubelements: Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(contentsOf: newSubelements, at: index)
        accept(newValue)
    }

    func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
}
