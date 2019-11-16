//
//  URL+AA.swift
//  AA
//
//  Created by Chris So on 7/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

extension URL {
    var isValid: Bool {
        return UIApplication.shared.canOpenURL(self)
    }

    private var _components: URLComponents {
        return URLComponents(url: self, resolvingAgainstBaseURL: true) ?? URLComponents()
    }

    var queryItems: [URLQueryItem] {
        return _components.queryItems ?? []
    }

    func queryValue(for keyName: String) -> String? {
        guard queryItems.count > 0 else {
            return nil
        }
        let value = queryItems.first(where: { $0.name == keyName })?.value ?? nil
        return value
    }

    var queryDictionary: [String: String]? {
        guard let urlComponents = URLComponents(string: absoluteString) else { return [:] }
        guard let queryItems: [URLQueryItem] = urlComponents.queryItems else { return [:] }
        return queryItems.reduce(into: [String: String]()) { dict, queryItem in
            dict[queryItem.name] = queryItem.value
        }
    }

    func queryDictionary(lowercasedKey: Bool = false, lowercasedValue: Bool = false) -> [String: String] {
        guard let urlComponents = URLComponents(string: absoluteString) else { return [:] }
        guard let queryItems: [URLQueryItem] = urlComponents.queryItems else { return [:] }
        return queryItems.reduce(into: [String: String]()) { dict, queryItem in
            let key = lowercasedKey ? queryItem.name.lowercased() : queryItem.name
            let value = lowercasedValue ? queryItem.value?.lowercased() : queryItem.value
            dict[key] = value
        }
    }

    /// url = https://www.testing.com?gg=1
    /// url.append("test", value: "123")
    /// url.append("test2", value: nil)
    /// url = https://www.testing.com?gg=1&test=123
    @discardableResult
    func append(_ key: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []

        // create query item if value is not nil
        guard let value = value else { return absoluteURL }
        let queryItem = URLQueryItem(name: key, value: value)

        // append the new query item in the existing query items array
        queryItems.append(queryItem)

        // append updated query items array in the url component object
        urlComponents.queryItems = queryItems // queryItems?.append(item)

        // returns the url from new url components
        return urlComponents.url!
    }
}
