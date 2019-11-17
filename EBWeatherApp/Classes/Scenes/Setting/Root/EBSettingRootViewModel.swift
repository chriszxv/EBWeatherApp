//
//  EBSettingRootViewModel.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBSettingRootViewModel: ViewModelType {
    struct Input {
        let triggerClose: Driver<Void>
        let triggerLanguageEN: Driver<Void>
        let triggerLanguageTC: Driver<Void>
        let triggerLanguageSC: Driver<Void>
        let triggerThemeLight: Driver<Void>
        let triggerThemeDark: Driver<Void>
        let triggerWebIcon8: Driver<Void>
    }

    struct Output {
//        let ???: Driver<Void>
    }

    private let navigator: EBSettingRootNavigator
    private let disposeBag = DisposeBag()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(navigator: EBSettingRootNavigator) {
        self.navigator = navigator
    }

    func transform(_ input: Input) -> Output {
        // Input
        input.triggerClose
            .drive(onNext: navigator.dismiss)
            .disposed(by: disposeBag)

        input.triggerLanguageEN
            .map { Localize.Language.Identifier.EN }
            .drive(onNext: Localize.setCurrentLanguage)
            .disposed(by: disposeBag)

        input.triggerLanguageTC
            .map { Localize.Language.Identifier.TC }
            .drive(onNext: Localize.setCurrentLanguage)
            .disposed(by: disposeBag)

        input.triggerLanguageSC
            .map { Localize.Language.Identifier.SC }
            .drive(onNext: Localize.setCurrentLanguage)
            .disposed(by: disposeBag)

        input.triggerThemeLight
            .drive(onNext: EBSettingRootViewModel._switchToLightTheme)
            .disposed(by: disposeBag)

        input.triggerThemeDark
            .drive(onNext: EBSettingRootViewModel._switchToDarkTheme)
            .disposed(by: disposeBag)

        input.triggerWebIcon8
            .map { URL(string: EBURLConstants.Icon8.Reference)! }
            .drive(onNext: navigator.showExternal)
            .disposed(by: disposeBag)

        // Output
        return Output()
    }
}

// MARK: - Theme

extension EBSettingRootViewModel {
    private static func _switchToLightTheme() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }

    private static func _switchToDarkTheme() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
}
