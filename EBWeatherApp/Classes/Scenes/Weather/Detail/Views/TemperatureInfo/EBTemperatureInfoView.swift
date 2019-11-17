//
//  EBTemperatureInfoView.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBTemperatureInfoView: UIView {
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var weatherConainerView: UIView!
    @IBOutlet private var weatherImageView: UIImageView!

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
        weatherConainerView.backgroundColor = R.color.background.surface()
        temperatureLabel.textColor = R.color.text.primary()
        weatherImageView.tintColor = R.color.background.primary()
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

extension EBTemperatureInfoView {
    // none
}

// MARK: - Observer

extension EBTemperatureInfoView {
    var viewModel: Binder<EBTemperatureInfoViewModel> {
        return Binder(self) { view, viewModel in
            if viewModel.isValid {
                view.temperatureLabel.text = viewModel.temperature
            } else {
                view.temperatureLabel.text = "--"
            }
            if let weatherImageKey = viewModel.weatherImageKey,
                let weatherImage = UIImage(named: weatherImageKey),
                let weatherHighlightedImageKey = viewModel.weatherHighlightedImageKey,
                let weatherHighlightedImage = UIImage(named: weatherHighlightedImageKey) {
                view.weatherImageView.image = weatherImage
                view.weatherImageView.highlightedImage = weatherHighlightedImage
            } else {
                view.weatherImageView.image = R.image.icon.weather.cloud_dash()
                view.weatherImageView.highlightedImage = R.image.icon.weather.cloud_dash_filled()
            }
        }
    }
}
