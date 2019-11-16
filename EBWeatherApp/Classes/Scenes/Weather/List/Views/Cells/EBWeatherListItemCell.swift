//
//  EBWeatherListItemCell.swift
//  EBWeatherApp
//
//  Created by product on 16/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherListItemCell: UITableViewCell {
    @IBOutlet private var shadowView: UIView!

    @IBOutlet private var containerView: UIView!

    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView!

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        _setupUIs()
        _setupBindings()
    }

    private func _setupUIs() {
//        shadowView.cornerRadius = 5.0
//        shadowView.shadowColor = UIColor.black
//        shadowView.shadowOpacity = 0.06
//        shadowView.shadowRadius = 2.0
//        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
//        containerView.cornerRadius = 5.0
//        thumbnailCotainerView.cornerRadius = 5.0
//        imageCountLabel.backgroundColor = UIColor.black.withAlphaComponent(0.66)
//        imageCountLabel.textColor = UIColor.white
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

// MARK: - Config

extension EBWeatherListItemCell {
    func configure(with viewModel: EBWeatherListItemCellModel) {
        cityNameLabel.text = viewModel.cityName
        dateLabel.text = viewModel.date
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
