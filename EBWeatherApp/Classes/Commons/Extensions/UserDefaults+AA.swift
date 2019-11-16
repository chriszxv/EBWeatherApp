//
//  UserDefaults+AA.swift
//  AA
//
//  Created by Chris So on 7/9/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import Foundation

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    func indexPathForKey(key: String) -> IndexPath {
        guard let indexArray = array(forKey: key) as? [Int] else { return IndexPath(row: 0, section: 0) }
        return IndexPath(row: indexArray[0], section: indexArray[1])
    }

    func setIndexPath(indexPath: IndexPath, forKey key: String) {
        set([indexPath.row, indexPath.section], forKey: key)
    }
}
