//
//  EBBaseRequests.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

enum EBRequestMethod: String {
    case GET
    case POST
}

enum EBRequestError: Error {
    case invalidFormat
}

protocol EBBaseRequest {
    var method: EBRequestMethod { get }
    var url: String { get }
    var parameters: [String: String] { get }
}

extension EBBaseRequest {
    func request() -> URLRequest {
        guard let url = URL(string: url) else {
            fatalError("Unable to find base URL")
        }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        var requestURL: URL
        var request: URLRequest
        if method == .GET {
            requestURL = components.url ?? URL(fileURLWithPath: "")
            request = URLRequest(url: requestURL)
        } else {
            // .POST
            requestURL = url
            request = URLRequest(url: requestURL)
            request.httpBody = components.percentEncodedQuery?.data(using: .utf8)
        }

        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
