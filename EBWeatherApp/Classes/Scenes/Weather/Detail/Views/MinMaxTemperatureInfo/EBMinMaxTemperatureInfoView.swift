//
//  EBMinMaxTemperatureInfoView.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class EBMinMaxTemperatureInfoView: UIView {
    @IBOutlet private var weatherConditionLabel: UILabel!
    @IBOutlet private var minMaxTemperatureLabel: UILabel!
    @IBOutlet private var separatorView: UIView!

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        _setupUIs()
        _setupBindings()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: 110)
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
        weatherConditionLabel.textColor = R.color.text.primary()
        minMaxTemperatureLabel.textColor = R.color.text.primary_light_20()
        separatorView.backgroundColor = R.color.background.surface()
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

extension EBMinMaxTemperatureInfoView {
    // none
}

// MARK: - Observer

extension EBMinMaxTemperatureInfoView {
    var viewModel: Binder<EBMinMaxTemperatureInfoViewModel> {
        return Binder(self) { view, viewModel in
            if viewModel.isValid {
                view.weatherConditionLabel.text = viewModel.weatherCondition
                view.minMaxTemperatureLabel.text = viewModel.minMaxTemperature
            } else {
                view.weatherConditionLabel.text = "N/A"
                view.minMaxTemperatureLabel.text = "--"
            }
        }
    }
}
