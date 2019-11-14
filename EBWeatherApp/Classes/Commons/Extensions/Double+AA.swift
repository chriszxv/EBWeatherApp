//
//  Double+AA.swift
//  AA
//
//  Created by Chris So on 25/6/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import Foundation

extension Double {
    var clean: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double {
    private static let moneyNumberFormatter = NumberFormatter()

    // 1234.5 > 1234.50
    func formatMoney(sign: Bool = false, percentage: Bool = false, minimumFractionDigits: Int = 2, maximumFractionDigits: Int = 2) -> String {
        let numberFormatter = Double.moneyNumberFormatter
        if percentage {
            numberFormatter.numberStyle = .percent
        } else {
            numberFormatter.numberStyle = .decimal
        }
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        if sign {
            numberFormatter.minusSign = "-"
            numberFormatter.plusSign = "+"
        } else {
            numberFormatter.minusSign = ""
            numberFormatter.plusSign = ""
        }
        return numberFormatter.string(from: NSNumber(value: self))!
    }

    private static let priceNumberFormatter = NumberFormatter()

    func formatPrice() -> String {
        let decimalPlace = 3
        let numberFormatter = Double.priceNumberFormatter
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = ""
        numberFormatter.decimalSeparator = "."
        numberFormatter.currencyDecimalSeparator = "."
        if self >= 1000 && decimalPlace > 0 {
            numberFormatter.minimumFractionDigits = 0 // 1234.5678  > 1235
            numberFormatter.maximumFractionDigits = 0 // 12345      > 12345
        } else if self >= 100 && decimalPlace > 2 {
            numberFormatter.minimumFractionDigits = 2 // 123.45678  >   123.45
            numberFormatter.maximumFractionDigits = 2 // 123        >   123.00
        } else if self >= 10 && decimalPlace > 3 {
            numberFormatter.minimumFractionDigits = 3 // 12.345678  >   12.345
            numberFormatter.maximumFractionDigits = 3 // 12         >   12.000
        } else {
            numberFormatter.minimumFractionDigits = decimalPlace
            numberFormatter.maximumFractionDigits = decimalPlace // Follow input decimal place
        }
        return numberFormatter.string(from: NSNumber(value: self))!
    }

    private static let changeNumberFormatter = NumberFormatter()

    // 1 > +1, 1 > +100%
    func formatChange(sign: Bool = false, percentage: Bool = false) -> String {
        let numberFormatter = Double.changeNumberFormatter
        if percentage {
            numberFormatter.numberStyle = .percent
        } else {
            numberFormatter.numberStyle = .decimal
        }
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.minimumFractionDigits = 3
        numberFormatter.maximumFractionDigits = 3
        if sign {
            numberFormatter.minusSign = "-"
            numberFormatter.plusSign = "+"
        } else {
            numberFormatter.minusSign = ""
            numberFormatter.plusSign = ""
        }
        return numberFormatter.string(from: NSNumber(value: self))!
    }

    private static let groupNumberFormatter = NumberFormatter()

    // 1000 -> 1,000
    func formatGroup(decimalPlace: Int = 0) -> String {
        let numberFormatter = Double.groupNumberFormatter
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.minimumFractionDigits = decimalPlace
        numberFormatter.maximumFractionDigits = decimalPlace
        return numberFormatter.string(from: NSNumber(value: self))!
    }

    // 1000 -> 1K
    func formatUnit(decimalPlace: Int = 0) -> String {
        var unit = ""
        var value = self
        if fabs(self) >= 1000000000000 {
            unit = "T"
            value /= Double(1000000000000)
        } else if fabs(self) >= 1000000000 {
            unit = "B"
            value /= Double(1000000000)
        } else if fabs(self) >= 1000000 {
            unit = "M"
            value /= Double(1000000)
        } else if fabs(self) >= 1000 {
            unit = "K"
            value /= Double(1000)
        }
        return "\(value.formatGroup(decimalPlace: decimalPlace))\(unit)"
    }
}
