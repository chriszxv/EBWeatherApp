//
//  EBWeatherSearchViewController.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherSearchViewController: EBBaseViewController {
    override class var storyboardName: String {
        return "EBWeather"
    }

    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var locateButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var textField: EBTextField!
    @IBOutlet private var tableView: UITableView!
    private let footerView = EBWeatherSearchFooterView(frame: CGRect(origin: .zero, size: CGSize(width: UIView.layoutFittingExpandedSize.width, height: 0)))
    private let topGradentView = EBGradientView()
    private let refreshControl = UIRefreshControl()
    private let toTopButton = EBToTopButton(type: .system)
    private let bottomGradentView = EBGradientView()
    private let networkEmptySetView = EBNetworkEmptySetView.instantiateFromXib()

    var viewModel: EBWeatherSearchViewModel!
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
        view.backgroundColor = .clear
        backgroundView.alpha = 0.95
        _setupTextField()
        _setupTableView()
        _setupTopGradentView()
        _setupBottomGradentView()
        _setupToTopButton()
        _setupEmptySetView()
    }

    private func _setupUITheme() {
        backgroundView.backgroundColor = R.color.background.background()
        locateButton.tintColor = R.color.background.primary()
        closeButton.tintColor = R.color.background.primary()
        tableView.backgroundColor = .clear
        topGradentView.isUserInteractionEnabled = false
        topGradentView.colors = [R.color.background.background() ?? .clear,
                                 R.color.background.background()?.withAlphaComponent(0.0) ?? .clear]
        bottomGradentView.isUserInteractionEnabled = false
        bottomGradentView.colors = [R.color.background.background()?.withAlphaComponent(0.0) ?? .clear,
                                    R.color.background.background() ?? .clear]
    }

    private func _setupTextField() {
        textField.backgroundColor = R.color.background.surface()
        textField.cornerRadius = 5.0
        textField.insetX = 10.0
    }

    private func _setupTableView() {
        tableView.register(EBWeatherSearchItemCell.nib, forCellReuseIdentifier: EBWeatherSearchItemCell.reuseIdentifier)
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = footerView
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = 60
        tableView.keyboardDismissMode = .onDrag
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
        Localize.languageDidChange
            .drive(onNext: { [unowned self] _ in
                self.textField.placeholder = R.string.localizable.placeholder_weather_search()
            })
            .disposed(by: disposeBag)
    }

    private func _bindUIs() {
        tableView.rx.reloadData
            .asDriverOnErrorJustComplete()
            .map { false }
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        tableView.rx.isNearTop
            .asDriverOnErrorJustComplete()
            .drive(toTopButton.rx.animated.fade().isHidden)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .asDriverOnErrorJustComplete()
            .drive(onNext: tableView.deselectRow)
            .disposed(by: disposeBag)

        toTopButton.rx.tap
            .asDriver()
            .drive(onNext: tableView.scrollToTop)
            .disposed(by: disposeBag)
    }

    private func _bindViewModel() {
        assert(viewModel != nil)

        let triggerLocation = locateButton.rx.tap.asDriver()
        let triggerClose = closeButton.rx.tap.asDriver()

        let triggerSearch = textField.rx.textChanged
            .asDriverOnErrorJustComplete()

        let triggerViewWillAppear = rx.viewWillAppear.asDriverOnErrorJustComplete().mapToVoid()
        let triggerRefreshControlRefresh = refreshControl.rx.controlEvent(.primaryActionTriggered).asDriver()
        let triggerNetworkEmptySetViewRefresh = networkEmptySetView.triggerRefresh
        let triggerRefresh = Driver.merge(triggerViewWillAppear,
                                          triggerRefreshControlRefresh,
                                          triggerNetworkEmptySetViewRefresh)

        let triggerItemSelected = tableView.rx.itemSelected
            .asDriver()
            .map { $0.row }

        let input = EBWeatherSearchViewModel.Input(triggerLocation: triggerLocation,
                                                   triggerClose: triggerClose,
                                                   triggerSearch: triggerSearch,
                                                   triggerRefresh: triggerRefresh,
                                                   triggerItemSelected: triggerItemSelected)
        let output = viewModel.transform(input)

        output.state
            .filter { $0 != .onDispose }
            .map { $0 != .onError }
            .drive(networkEmptySetView.rx.isHidden)
            .disposed(by: disposeBag)

        output.isGettingLocation
            .map { !$0 }
            .drive(locateButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)

        output.isGettingLocation
            .drive(locateButton.rx.isHighlighted)
            .disposed(by: disposeBag)

        output.cellModels
            .drive(tableView.rx.items) { tableView, row, item in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: EBWeatherSearchItemCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: item)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
