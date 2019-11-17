//
//  KeyedDecodingContainer.swift
//  AA
//
//  Created by Chris So on 17/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        return try decode(T.self, forKey: key)
    }

    public func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}
