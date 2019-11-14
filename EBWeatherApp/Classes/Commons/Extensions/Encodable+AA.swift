//
//  Encodable.swift
//  AA
//
//  Created by Chris So on 18/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import Foundation

extension Encodable {
    func toArray() -> [Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [Any] }
    }

    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    func toJsonString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func toJsonData() -> Data? {
        guard let string = self.toJsonString() else { return nil }
        return string.data(using: .utf8)
    }
}
