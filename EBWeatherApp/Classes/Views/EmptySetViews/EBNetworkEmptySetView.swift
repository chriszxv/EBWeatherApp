//
//  EBNetworkEmptySetView.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBNetworkEmptySetView: UIView {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var refreshButton: UIButton!

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
        refreshButton.tintColor = R.color.background.primary()
    }

    private func _setupBindings() {
        _bindLocaleService()
        _bindUIs()
    }

    private func _bindLocaleService() {
        Localize.languageDidChange
            .drive(onNext: { [unowned self] _ in
                self.messageLabel.text = R.string.localizable.error_message_network()
            })
            .disposed(by: disposeBag)
    }

    private func _bindUIs() {
        // None
    }
}

// MARK: - Observable

extension EBNetworkEmptySetView {
    var triggerRefresh: Driver<Void> {
        return refreshButton.rx.tap.asDriver()
    }
}

// MARK: - Observer

extension EBNetworkEmptySetView {
    var messageTitle: Binder<String?> {
        return messageLabel.rx.text
    }
}
