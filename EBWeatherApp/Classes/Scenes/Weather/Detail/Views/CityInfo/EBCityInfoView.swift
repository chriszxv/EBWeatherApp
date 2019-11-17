//
//  EBCityInfoView.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBCityInfoView: UIView {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var cityCountryCodeLabel: UILabel!
    @IBOutlet private var coordinateLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

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
        containerView.backgroundColor = R.color.background.surface()
        cityNameLabel.textColor = R.color.text.primary()
        cityCountryCodeLabel.textColor = R.color.text.primary_light_20()
        coordinateLabel.textColor = R.color.text.primary_light_20()
        dateLabel.textColor = R.color.text.primary_light_20()
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

extension EBCityInfoView {
    // none
}

// MARK: - Observer

extension EBCityInfoView {
    var viewModel: Binder<EBCityInfoViewModel> {
        return Binder(self) { view, viewModel in
            if viewModel.isValid {
                view.cityNameLabel.text = viewModel.cityName
                view.cityCountryCodeLabel.text = viewModel.cityCountryCode
                view.coordinateLabel.text = viewModel.coordinate
                view.dateLabel.text = viewModel.date
            } else {
                view.cityNameLabel.text = "..."
                view.cityCountryCodeLabel.text = "..."
                view.coordinateLabel.text = "--"
                view.dateLabel.text = "--"
            }
        }
    }
}
