//
//  EBWeatherListFooterView.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit

final class EBWeatherListFooterView: UIView {
    private let addButton = UIButton(type: .system)
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
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: 100)
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
        addButton.setImage(R.image.icon.action.plus_circle(), for: .normal)
        addButton.setImage(R.image.icon.action.plus_circle_filled(), for: .highlighted)

        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
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

// MARK: - Observable

extension EBWeatherListFooterView {
    var triggerAdd: Driver<Void> {
        return addButton.rx.tap.asDriver()
    }
}

// MARK: - Observer

extension EBWeatherListFooterView {
    // None
}
