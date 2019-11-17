//
//  EBWeatherSearchItemCell.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherSearchItemCell: UITableViewCell {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var cityCountryCodeLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView!

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

        let view = UIView()
        view.backgroundColor = R.color.background.primary_heavy_20()
        selectedBackgroundView = view

        cityNameLabel.textColor = R.color.text.primary()
        cityCountryCodeLabel.textColor = R.color.text.primary_light_20()
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

// MARK: - Config

extension EBWeatherSearchItemCell {
    func configure(with viewModel: EBWeatherSearchItemCellModel) {
        cityNameLabel.text = viewModel.cityName
        cityCountryCodeLabel.text = viewModel.cityCountryCode
        temperatureLabel.text = viewModel.temperature
        if let weatherImageKey = viewModel.weatherImageKey,
            let weatherImage = UIImage(named: weatherImageKey),
            let weatherHighlightedImageKey = viewModel.weatherHighlightedImageKey,
            let weatherHighlightedImage = UIImage(named: weatherHighlightedImageKey) {
            weatherImageView.image = weatherImage
            weatherImageView.highlightedImage = weatherHighlightedImage
        } else {
            weatherImageView.image = R.image.icon.weather.cloud_dash()
            weatherImageView.highlightedImage = R.image.icon.weather.cloud_dash_filled()
        }
    }
}
