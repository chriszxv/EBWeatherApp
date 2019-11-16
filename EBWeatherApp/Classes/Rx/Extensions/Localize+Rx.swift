//
//  Localize+Rx.swift
//  AA
//
//  Created by Chris So on 23/7/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

extension Localize {
    private static let _languageRelay = BehaviorRelay<Void>(value: ())
    private static let disposeBag = DisposeBag()
}

// MARK: - Action

extension Localize {
    static func setup() {
        _setupBindings()
    }

    private static func _setupBindings() {
        UserDefaults.standard.rx
            .observe(String.self, Localize.UserDefaultsKey.AppleLanguages)
            .debounce(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .asDriverOnErrorJustComplete()
            .mapToVoid()
            .drive(Localize._languageRelay)
            .disposed(by: Localize.disposeBag)
    }

    static var currentLanguageIdentifierDriver: Driver<String> {
        return languageDidChange.map { currentLanguageIdentifier }
    }

    static var currentLanguageCodeDriver: Driver<String> {
        return languageDidChange.map { currentLanguageCode }
    }

    static var languageDidChange: Driver<Void> {
        return _languageRelay.asDriver()
    }
}
