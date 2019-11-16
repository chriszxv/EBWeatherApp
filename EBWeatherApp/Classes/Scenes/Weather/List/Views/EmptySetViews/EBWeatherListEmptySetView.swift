//
//  EBWeatherListEmptySetView.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherListEmptySetView: UIView {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var locateButton: UIButton!

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

extension EBWeatherListEmptySetView {
    var triggerLocate: Driver<Void> {
        return locateButton.rx.tap.asDriver()
    }

    var triggerRefresh: Driver<Void> {
        return refreshButton.rx.tap.asDriver()
    }
}

// MARK: - Observer

extension EBWeatherListEmptySetView {
    // None
}
