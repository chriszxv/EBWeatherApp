//
//  EBToTopButton.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBToTopButton: UIButton {
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUIs()
        _setupBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupUIs()
        _setupBindings()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 40)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection),
                hasUserInterfaceStyleChanged == true {
                _setupUITheme()
            }
        }
    }

    private func _setupUIs() {
        _setupUITheme()
        alpha = 0.75
        setImage(R.image.icon.action.chevron_top_circle(), for: .normal)
        setImage(R.image.icon.action.chevron_top_circle_filled(), for: .highlighted)
    }

    private func _setupUITheme() {
        tintColor = R.color.background.primary()
    }

    private func _setupBindings() {
        _bindLocaleService()
        _bindUIs()
    }

    private func _bindLocaleService() {
        // None
    }

    private func _bindUIs() {
        // None
    }
}
