//
//  EBSettingRootViewController.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBSettingRootViewController: EBBaseViewController {
    override class var storyboardName: String {
        return "EBSetting"
    }

    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var languageENButton: UIButton!
    @IBOutlet private var languageTCButton: UIButton!
    @IBOutlet private var languageSCButton: UIButton!
    @IBOutlet private var themeLabel: UILabel!
    @IBOutlet private var themeLightButton: UIButton!
    @IBOutlet private var themeDarkButton: UIButton!
    @IBOutlet private var iconLabel: UILabel!
    @IBOutlet private var iconActionButton: UIButton!

    var viewModel: EBSettingRootViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupUIs()
        _setupBindings()
    }

    private func _setupUIs() {
        // None
    }

    private func _setupBindings() {
        _bindThemeService()
        _bindLocaleService()
        _bindViewModel()
    }

    private func _bindThemeService() {
        // None
    }

    private func _bindLocaleService() {
        Localize.languageDidChange
            .drive(onNext: { [unowned self] _ in
                self.titleLabel.text = R.string.localizable.setting_title.key.localized
                self.languageLabel.text = R.string.localizable.setting_title_language.key.localized
                self.themeLabel.text = R.string.localizable.setting_title_theme.key.localized
                self.themeLightButton.setTitle(R.string.localizable.setting_value_light.key.localized, for: .normal)
                self.themeDarkButton.setTitle(R.string.localizable.setting_value_dark.key.localized, for: .normal)
                self.iconLabel.text = R.string.localizable.setting_title_icon.key.localized
            })
            .disposed(by: disposeBag)
    }

    private func _bindViewModel() {
        assert(viewModel != nil)

        let triggerClose = closeButton.rx.tap.asDriver()

        let triggerLanguageEN = languageENButton.rx.tap.asDriver()
        let triggerLanguageTC = languageTCButton.rx.tap.asDriver()
        let triggerLanguageSC = languageSCButton.rx.tap.asDriver()
        let triggerThemeLight = themeLightButton.rx.tap.asDriver()
        let triggerThemeDark = themeDarkButton.rx.tap.asDriver()
        let triggerWebIcon8 = iconActionButton.rx.tap.asDriver()

        let input = EBSettingRootViewModel.Input(triggerClose: triggerClose,
                                                 triggerLanguageEN: triggerLanguageEN,
                                                 triggerLanguageTC: triggerLanguageTC,
                                                 triggerLanguageSC: triggerLanguageSC,
                                                 triggerThemeLight: triggerThemeLight,
                                                 triggerThemeDark: triggerThemeDark,
                                                 triggerWebIcon8: triggerWebIcon8)
        let output = viewModel.transform(input)

        print(output)
    }
}
