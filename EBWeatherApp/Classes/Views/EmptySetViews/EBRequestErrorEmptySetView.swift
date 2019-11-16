//
//  EBRequestErrorEmptySetView.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBRequestErrorEmptySetView: UIView {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var refreshButton: UIButton!

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        _setupUIs()
        _setupBindings()
    }

    private func _setupUIs() {
        // None
    }

    private func _setupBindings() {
        _bindThemeService()
        _bindLocaleService()
        _bindUIs()
    }

    private func _bindThemeService() {
        // None
    }

    private func _bindLocaleService() {
        // None
    }

    private func _bindUIs() {
        // None
    }
}

// MARK: - Observable

extension EBRequestErrorEmptySetView {
    var triggerRefresh: Driver<Void> {
        return refreshButton.rx.tap.asDriver()
    }
}

// MARK: - Observer

extension EBRequestErrorEmptySetView {
    var messageTitle: Binder<String?> {
        return messageLabel.rx.text
    }
}
