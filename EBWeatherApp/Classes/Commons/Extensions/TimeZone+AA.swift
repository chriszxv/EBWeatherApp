//
//  TimeZone.swift
//  AA
//
//  Created by Chris So on 2/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import Foundation

extension TimeZone {
    static func HongKongTimeZone() -> TimeZone {
        return TimeZone(secondsFromGMT: 8 * 60 * 60) ?? TimeZone.current // +8 hour
    }
}
