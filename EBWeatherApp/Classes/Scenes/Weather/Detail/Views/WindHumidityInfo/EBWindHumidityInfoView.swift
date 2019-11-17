//
//  EBWindHumidityInfoView.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWindHumidityInfoView: UIView {
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
        backgroundColor = R.color.background.background()
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

extension EBWindHumidityInfoView {
    // none
}

// MARK: - Observer

extension EBWindHumidityInfoView {
    var viewModel: Binder<EBWindHumidityInfoViewModel> {
        return Binder(self) { view, viewModel in
            if viewModel.isValid {
                view.windLabel.text = viewModel.wind
                view.humidityLabel.text = viewModel.humidity
            } else {
                view.windLabel.text = "--"
                view.humidityLabel.text = "--"
            }
        }
    }
}
