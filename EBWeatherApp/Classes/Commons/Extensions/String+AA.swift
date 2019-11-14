//
//  DateFormattingString.swift
//  AA
//
//  Created by Chris So on 2/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

// MARK: - Substring

extension String {
    func slice(from: String, to: String) -> String {
        return (range(of: from)?.upperBound)
            .flatMap { substringFrom in
                (range(of: to, range: substringFrom ..< endIndex)?.lowerBound)
                    .map { substringTo in
                        String(self[substringFrom ..< substringTo])
                    }
            } ?? ""
    }

    func slice(after: String) -> String {
        let index = endIndexes(of: after).last ?? endIndex
        return String(self[index...])
    }

    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}

// MARK: Size

extension String {
    func boundingRect(with size: CGSize, options: NSStringDrawingOptions = [], attributes: [NSAttributedString.Key: Any]? = nil, context: NSStringDrawingContext?) -> CGRect {
        let string = self as NSString
        return string.boundingRect(with: size, options: options, attributes: attributes, context: context)
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

// MARK: - Numeric

extension String {
    func isNumeric() -> Bool {
        return Double(self) != nil
    }
}

// MARK: - Index

extension StringProtocol where Index == String.Index {
    func startIndex<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }

    func endIndex<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }

    func startIndexes<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start ..< endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }

    func endIndexes<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start ..< endIndex) {
            result.append(range.upperBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }

    func ranges<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start ..< endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

// MARK: - URL

extension String {
    func urlEscapedString() -> String {
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        let escapedString = addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
        return escapedString ?? ""
    }
}

// MARK: - Date

extension String {
    func date(dateFormat: DateFormatString) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = TimeZone.HongKongTimeZone()
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }

    func dateString(fromFormat: DateFormatString, toFormat: DateFormatString) -> String {
        let date = self.date(dateFormat: fromFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat.rawValue
        dateFormatter.timeZone = TimeZone.HongKongTimeZone()
        let formattedDateString: String = dateFormatter.string(from: date)
        return formattedDateString
    }
}
