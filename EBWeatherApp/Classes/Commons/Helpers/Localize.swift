//
//  Localize.swift
//  AA
//
//  Created by Chris So on 22/7/2019.
//  Copyright © 2018 Chris So. All rights reserved.
//

import Foundation

struct Localize {
    struct UserDefaultsKey {
        static let AppleLanguages = "AppleLanguages"
    }

    static let LanguageDidChangeNotification = Notification.Name("Localize.LanguageDidChangeNotification")

    struct Language {
        struct Identifier {
            static let EN = "en"
            static let TC = "zh-Hant"
            static let SC = "zh-Hans"
        }

        struct Code {
            static let EN = "en"
            static let TC = "tc"
            static let SC = "sc"
        }
    }

    private static var _currentSystemLanguageString: String {
        guard let languages = (UserDefaults.standard.object(forKey: UserDefaultsKey.AppleLanguages) as? NSArray) else {
            return NSLocale.preferredLanguages[0] as String
        }
        return languages[0] as! String
    }

    static var currentLanguageIdentifier: String {
        let language = _currentSystemLanguageString
        if language.hasPrefix(Language.Identifier.EN) {
            return Language.Identifier.EN
        } else if language.hasPrefix(Language.Identifier.SC) {
            return Language.Identifier.SC
        } else {
            return Language.Identifier.TC
        }
    }

    static var currentLanguageCode: String {
        let language = _currentSystemLanguageString
        if language.hasPrefix(Language.Identifier.EN) {
            return Language.Code.EN
        } else if language.hasPrefix(Language.Identifier.SC) {
            return Language.Code.SC
        } else {
            return Language.Code.TC
        }
    }

    static func localizedString(key: String, comment: String = "") -> String {
        let bundle = Bundle(for: BundleResource.self)
        guard let path = bundle.path(forResource: currentLanguageIdentifier, ofType: "lproj") else {
            return NSLocalizedString(key as String, comment: comment)
        }
        return (Bundle(path: path)?.localizedString(forKey: key as String, value: "", table: nil))! as String
    }

    static func setCurrentLanguage(with identifier: String) {
        guard let languages = (UserDefaults.standard.object(forKey: UserDefaultsKey.AppleLanguages) as? NSArray) else {
            return
        }
        let newLanguages = languages.mutableCopy() as! NSMutableArray
        newLanguages.replaceObject(at: 0, with: identifier)
        UserDefaults.standard.setValue(newLanguages, forKey: UserDefaultsKey.AppleLanguages)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: LanguageDidChangeNotification, object: nil)
    }
}

// MARK: - String

extension String {
    var localized: String {
        return Localize.localizedString(key: self)
    }

    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, arguments: args)
    }
}
