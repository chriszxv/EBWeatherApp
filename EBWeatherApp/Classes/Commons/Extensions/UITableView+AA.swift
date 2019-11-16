//
//  UITableView+AA.swift
//  AA
//
//  Created by Chris So on 7/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func deselectRow(at indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
    }

    func validate(indexPath: IndexPath) -> Bool {
        if indexPath.section >= numberOfSections {
            return false
        } else if indexPath.row >= numberOfRows(inSection: indexPath.section) {
            return false
        } else {
            return true
        }
    }

    @objc override func scrollToTop() {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        if validate(indexPath: firstIndexPath) == true {
            scrollToRow(at: firstIndexPath, at: .top, animated: true)
        } else {
            setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
