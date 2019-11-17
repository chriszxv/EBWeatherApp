//
//  EBListEmptySetView.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBListEmptySetView: UIView {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var addButton: UIButton!

    var messageLabelText: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        _setupUIs()
        _setupBindings()
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
    }

    private func _setupUITheme() {
        backgroundColor = R.color.background.background()
        iconImageView.tintColor = R.color.background.surface()
        messageLabel.tintColor = R.color.text.primary()
        addButton.tintColor = R.color.background.primary()
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

extension EBListEmptySetView {
    var triggerAdd: Driver<Void> {
        return addButton.rx.tap.asDriver()
    }
}

// MARK: - Observer

extension EBListEmptySetView {
    // None
}
