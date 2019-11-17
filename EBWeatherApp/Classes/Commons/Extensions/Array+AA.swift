//
//  Array+AA.swift
//  AA
//
//  Created by Chris So on 23/8/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

extension Array {
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func toJsonData() -> Data? {
        guard let string = self.toJsonString() else { return nil }
        return string.data(using: .utf8)
    }
}
