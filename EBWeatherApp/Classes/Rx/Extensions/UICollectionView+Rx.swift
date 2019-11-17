//
//  UICollectionView+Rx.swift
//  AA
//
//  Created by Chris So on 28/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UICollectionView {
    /// Reactive wrapper for `reloadData`
    var reloadData: Observable<Void> {
        return sentMessage(#selector(Base.reloadData))
            .map { _ in }
    }
}

// MARK: - Observer

public extension Reactive where Base: UICollectionView {
    /// Bindable sink for `selectItem(at:animated:scrollPosition:)`
    func selectItem(animated: Bool, scrollPosition: UICollectionView.ScrollPosition) -> Binder<IndexPath> {
        return Binder(base) { collectionView, indexPath in
            if collectionView.visibleCells.count > 0 {
                collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
            }
        }
    }
}
