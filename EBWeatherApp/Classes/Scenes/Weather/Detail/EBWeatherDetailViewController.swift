//
//  EBWeatherDetailViewController.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

import RxCocoa
import RxSwift

class EBWeatherDetailViewController: EBBaseViewController {
    override class var storyboardName: String {
        return "EBWeather"
    }

    @IBOutlet private var scrollStackView: EBScrollStackView!

    private let cityInfoView = EBCityInfoView.instantiateFromXib()
    private let temperatureInfoView = EBTemperatureInfoView.instantiateFromXib()
    private let minMaxTemperatureInfoView = EBMinMaxTemperatureInfoView.instantiateFromXib()
    private let windHumidityInfoView = EBWindHumidityInfoView.instantiateFromXib()

    private let topGradentView = EBGradientView()
    private let refreshControl = UIRefreshControl()
    private let toTopButton = EBToTopButton(type: .system)
    private let bottomGradentView = EBGradientView()
    private let networkEmptySetView = EBNetworkEmptySetView.instantiateFromXib()

    var viewModel: EBWeatherDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        navigationController?.hidesBarsOnSwipe = false
        _setupScrollStackView()
        _setupTopGradentView()
        _setupBottomGradentView()
        _setupToTopButton()
        _setupEmptySetView()
    }

    private func _setupUITheme() {
        topGradentView.isUserInteractionEnabled = false
        topGradentView.colors = [R.color.background.background() ?? .clear,
                                 R.color.background.background()?.withAlphaComponent(0.0) ?? .clear]
        bottomGradentView.isUserInteractionEnabled = false
        bottomGradentView.colors = [R.color.background.background()?.withAlphaComponent(0.0) ?? .clear,
                                    R.color.background.background() ?? .clear]
    }

    private func _setupScrollStackView() {
        scrollStackView.scrollView.addSubview(refreshControl)
        scrollStackView.stackView.addArrangedSubview(cityInfoView)
        scrollStackView.stackView.addArrangedSubview(temperatureInfoView)
        scrollStackView.stackView.addArrangedSubview(minMaxTemperatureInfoView)
        scrollStackView.stackView.addArrangedSubview(windHumidityInfoView)
        scrollStackView.stackView.addArrangedSubview(UIView())
        cityInfoView.snp.makeConstraints { make in
            make.height.equalTo(cityInfoView.bounds.size.height).priority(999)
        }
        temperatureInfoView.snp.makeConstraints { make in
            make.height.equalTo(temperatureInfoView.bounds.size.height).priority(999)
        }
        minMaxTemperatureInfoView.snp.makeConstraints { make in
            make.height.equalTo(minMaxTemperatureInfoView.bounds.size.height).priority(999)
        }
        windHumidityInfoView.snp.makeConstraints { make in
            make.height.equalTo(windHumidityInfoView.bounds.size.height).priority(999)
        }
    }

    private func _setupTopGradentView() {
        view.addSubview(topGradentView)
        topGradentView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }

    private func _setupEmptySetView() {
        networkEmptySetView.isHidden = true
        view.addSubview(networkEmptySetView)
        networkEmptySetView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    private func _setupBindings() {
        _bindLocaleService()
        _bindUIs()
        _bindViewModel()
    }

    private func _setupBottomGradentView() {
        view.addSubview(bottomGradentView)
        bottomGradentView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
            make.right.equalTo(view)
        }
    }

    private func _setupToTopButton() {
        view.addSubview(toTopButton)
        toTopButton.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }

    private func _bindLocaleService() {
        // None
    }

    private func _bindUIs() {
        scrollStackView.scrollView.rx.isNearTop
            .asDriverOnErrorJustComplete()
            .drive(toTopButton.rx.animated.fade().isHidden)
            .disposed(by: disposeBag)

        toTopButton.rx.tap
            .asDriver()
            .drive(onNext: scrollStackView.scrollView.scrollToTop)
            .disposed(by: disposeBag)
    }

    private func _bindViewModel() {
        assert(viewModel != nil)

        let triggerViewWillAppear = rx.viewWillAppear.asDriverOnErrorJustComplete().mapToVoid()
        let triggerRefreshControlRefresh = refreshControl.rx.controlEvent(.primaryActionTriggered).asDriver()
        let triggerNetworkEmptySetViewRefresh = networkEmptySetView.triggerRefresh
        let triggerRefresh = Driver.merge(triggerViewWillAppear,
                                          triggerRefreshControlRefresh,
                                          triggerNetworkEmptySetViewRefresh)

        let input = EBWeatherDetailViewModel.Input(triggerRefresh: triggerRefresh)
        let output = viewModel.transform(input)

        output.state
            .filter { $0 != .onDispose }
            .map { $0 != .onError }
            .drive(networkEmptySetView.rx.isHidden)
            .disposed(by: disposeBag)

        output.state
            .filter { $0 != .onDispose }
            .map { $0 == .onError || $0 == .onCompleted }
            .mapToVoid()
            .map { false }
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        output.cityInfoViewModel
            .drive(cityInfoView.viewModel)
            .disposed(by: disposeBag)

        output.temperatureInfoViewModel
            .drive(temperatureInfoView.viewModel)
            .disposed(by: disposeBag)

        output.minMaxTemperatureInfoViewModel
            .drive(minMaxTemperatureInfoView.viewModel)
            .disposed(by: disposeBag)

        output.windHumidityInfoViewModel
            .drive(windHumidityInfoView.viewModel)
            .disposed(by: disposeBag)
    }
}
