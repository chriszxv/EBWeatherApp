//
//  EBWeatherListHeaderView.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherListHeaderView: UIView {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var cityCountryCodeLabel: UILabel!
    @IBOutlet private var pinImageView: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView!
    @IBOutlet private var minMaxTemperatureLabel: UILabel!
    @IBOutlet private var windImageView: UIImageView!
    @IBOutlet private var windLabel: UILabel!
    @IBOutlet private var humidityImageView: UIImageView!
    @IBOutlet private var humidityLabel: UILabel!
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
        backgroundColor = R.color.background.surface()
        cityNameLabel.textColor = R.color.text.primary()
        cityCountryCodeLabel.textColor = R.color.text.primary_light_20()
        pinImageView.tintColor = R.color.text.primary_light_20()
        temperatureLabel.textColor = R.color.text.primary()
        weatherImageView.tintColor = R.color.background.primary()
        minMaxTemperatureLabel.textColor = R.color.text.primary_light_20()
        windImageView.tintColor = R.color.text.primary_light_20()
        windLabel.textColor = R.color.text.primary_light_20()
        humidityImageView.tintColor = R.color.text.primary_light_20()
        humidityLabel.textColor = R.color.text.primary_light_20()
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

extension EBWeatherListHeaderView {
    // none
}

// MARK: - Observer

extension EBWeatherListHeaderView {
    var viewModel: Binder<EBWeatherListHeaderViewModel> {
        return Binder(self) { view, viewModel in
            if viewModel.isValid {
                view.cityNameLabel.text = viewModel.cityName
                view.cityCountryCodeLabel.text = viewModel.cityCountryCode
                view.temperatureLabel.text = viewModel.temperature
                view.minMaxTemperatureLabel.text = viewModel.minMaxTemperature
                view.windLabel.text = viewModel.wind
                view.humidityLabel.text = viewModel.humidity
            } else {
                view.cityNameLabel.text = "..."
                view.cityCountryCodeLabel.text = "..."
                view.temperatureLabel.text = "--"
                view.minMaxTemperatureLabel.text = "--"
                view.windLabel.text = "--"
                view.humidityLabel.text = "--"
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
