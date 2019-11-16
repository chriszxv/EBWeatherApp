//
//  Date+AA.swift
//  AA
//
//  Created by Chris So on 27/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import Foundation

// MARK: - Relative Date

extension Date {
    static let relativeDateLocale = [
        "tc": [
            "year": "年前",
            "month": "個月前",
            "week": "周前",
            "yesterday": "昨天",
            "days": "日前",
            "hour": " 小時前",
            "minute": "分鐘前",
            "second": "秒前",
            "now": "剛剛",
            "s": "",
            "ago": "",
            "today": "今日",
        ],
        "sc": [
            "year": "年前",
            "month": "个月前",
            "week": "周前",
            "yesterday": "昨天",
            "days": "日前",
            "hour": "小时前",
            "minute": "分钟前",
            "second": "秒前",
            "now": "刚刚",
            "s": "",
            "ago": "",
            "today": "今天",
        ],
        "en": [
            "year": " year",
            "month": " month",
            "week": " week",
            "yesterday": "Yesterday",
            "days": " days",
            "hour": " hour",
            "minute": " minute",
            "second": " second",
            "now": "Now",
            "s": "s",
            "ago": " ago",
            "today": "Today",
        ],
    ]

    private func _languageCodeFromSystem() -> String {
        let language: String
        if let languages = (UserDefaults.standard.object(forKey: "AppleLanguages") as? NSArray) {
            language = languages[0] as! String
        } else {
            language = NSLocale.preferredLanguages[0] as String
        }
        if language.hasPrefix("en") {
            return "en"
        } else if language.hasPrefix("zh-Hans") {
            return "sc"
        } else {
            return "tc"
        }
    }

    private func _localeFromSystem() -> Locale {
        let language: String
        if let languages = (UserDefaults.standard.object(forKey: "AppleLanguages") as? NSArray) {
            language = languages[0] as! String
        } else {
            language = NSLocale.preferredLanguages[0] as String
        }
        return Locale(identifier: language)
    }

    private func _isToday() -> ComparisonResult {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.HongKongTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today)
        let todayDate = dateFormatter.date(from: todayString)
        return compare(todayDate!)
    }

    var yearsFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.year], from: self, to: Date()).year ?? 0
    }

    var monthsFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.month], from: self, to: Date()).month ?? 0
    }

    var weeksFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
    }

    var daysFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.day], from: self, to: Date()).day ?? 0
    }

    var hoursFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.hour], from: self, to: Date()).hour ?? 0
    }

    var minutesFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.minute], from: self, to: Date()).minute ?? 0
    }

    var secondsFromNow: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        return calendar.dateComponents([.second], from: self, to: Date()).second ?? 0
    }

    func relativeDateString(for languageCode: String = "") -> String {
        let locale: String
        if languageCode.isEmpty {
            locale = _languageCodeFromSystem()
        } else {
            locale = languageCode
        }
        guard let relativeDateLocale = Date.relativeDateLocale[locale] else {
            return ""
        }
        if yearsFromNow > 0 {
            return "\(yearsFromNow)" + relativeDateLocale["year"]! + (yearsFromNow > 1 ? relativeDateLocale["s"]! : "") + relativeDateLocale["ago"]!
        } else if monthsFromNow > 0 {
            return "\(monthsFromNow)" + relativeDateLocale["month"]! + (monthsFromNow > 1 ? relativeDateLocale["s"]! : "") + relativeDateLocale["ago"]!
        } else if weeksFromNow > 0 {
            return "\(weeksFromNow)" + relativeDateLocale["week"]! + (weeksFromNow > 1 ? relativeDateLocale["s"]! : "") + relativeDateLocale["ago"]!
        } else if daysFromNow > 0 {
            return "\(daysFromNow)" + relativeDateLocale["days"]! + relativeDateLocale["ago"]!
        } else if hoursFromNow > 0 {
            return "\(hoursFromNow)" + relativeDateLocale["hour"]! + (hoursFromNow > 1 ? relativeDateLocale["s"]! : "") + relativeDateLocale["ago"]!
        } else if minutesFromNow > 0 {
            return "\(minutesFromNow)" + relativeDateLocale["minute"]! + (minutesFromNow > 1 ? relativeDateLocale["s"]! : "") + relativeDateLocale["ago"]!
        } else if secondsFromNow > 0 {
            return relativeDateLocale["now"]!
        } else {
            return relativeDateLocale["now"]!
        }
    }

    func relativeWeekString(for languageCode: String = "") -> String {
        let locale: String
        if languageCode.isEmpty {
            locale = _languageCodeFromSystem()
        } else {
            locale = languageCode
        }
        guard let relativeDateLocale = Date.relativeDateLocale[locale] else {
            return ""
        }
        if _isToday() == .orderedSame {
            return relativeDateLocale["today"]!
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = _localeFromSystem()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: self)
        }
    }
}

// MARK: - Convertion

extension Date {
    var dateComponents: DateComponents {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.HongKongTimeZone()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return components
    }

    func string(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.HongKongTimeZone()
        let string = dateFormatter.string(from: self)
        return string
    }
}

// MARK: - Unit

extension Date {
    // Date with start time: 00:00:00
    static func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }

    // Date with start time: 23:59:59
    static func endOfDay(for date: Date) -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: date)!
    }

    // Today with start time: 00:00:00
    static var startOfToday: Date {
        return startOfDay(for: Date())
    }

    // Today with start time: 23:59:59
    static var endOfToday: Date {
        return endOfDay(for: Date())
    }
}

// MARK: - Unix Timestamp

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((timeIntervalSince1970 * 1000.0).rounded())
    }

    init(millisecondsSince1970: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millisecondsSince1970) / 1000)
    }
}
