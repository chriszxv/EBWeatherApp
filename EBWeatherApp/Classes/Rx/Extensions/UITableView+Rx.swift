//
//  UITableView+Rx.swift
//  AA
//
//  Created by Chris So on 6/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - Observable

public extension Reactive where Base: UITableView {
    /// Reactive wrapper for `reloadData`
    var reloadData: Observable<Void> {
        return sentMessage(#selector(Base.reloadData))
            .map { _ in }
    }

    /// Reactive wrapper for `delegate` message `tableView(_:commit:forRowAt:)`
    var itemOtherAction: ControlEvent<IndexPath> {
        let source = dataSource.methodInvoked(#selector(UITableViewDataSource.tableView(_:commit:forRowAt:)))
            .filter { a in
                guard let editingStyle = a[1] as? NSNumber else {
                    return false
                }
                return UITableViewCell.EditingStyle(rawValue: editingStyle.intValue) == UITableViewCell.EditingStyle.none
            }
            .map { (a) -> IndexPath in
                if let indexPath = a[2] as? IndexPath {
                    return indexPath
                } else {
                    return IndexPath()
                }
            }
        return ControlEvent(events: source)
    }
}

// MARK: - Observer

public extension Reactive where Base: UITableView {
    /// Bindable sink for `selectItem(at:animated:scrollPosition:)`
    func selectRow(animated: Bool, scrollPosition: UITableView.ScrollPosition) -> Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            if tableView.visibleCells.count > 0 {
                tableView.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
            }
        }
    }

    func scrollToRow(at scrollPosition: UITableView.ScrollPosition, animated: Bool) -> Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        }
    }
}
