//
//  UICollectionView+AA.swift
//  AA
//
//  Created by Chris So on 20/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.reuseIdentifier)")
        }
        return supplementaryView
    }
}

extension UICollectionView {
    func validate(indexPath: IndexPath) -> Bool {
        if indexPath.section >= numberOfSections {
            return false
        } else if indexPath.row >= numberOfItems(inSection: indexPath.section) {
            return false
        } else {
            return true
        }
    }
}
