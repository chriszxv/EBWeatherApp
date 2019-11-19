//
//  EBWeatherListViewController.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit

class EBWeatherListViewController: EBBaseViewController {
    override class var storyboardName: String {
        return "EBWeather"
    }

    @IBOutlet private var settingButton: UIButton!
    @IBOutlet private var tableView: UITableView!
    private let headerView = EBWeatherListHeaderView.instantiateFromXib()
    private let footerView = EBWeatherListFooterView(frame: CGRect(origin: .zero, size: CGSize(width: UIView.layoutFittingExpandedSize.width, height: 100)))
    private let topGradentView = EBGradientView()
    private let refreshControl = UIRefreshControl()
    private let toTopButton = EBToTopButton(type: .system)
    private let bottomGradentView = EBGradientView()
    private let listEmptySetView = EBListEmptySetView.instantiateFromXib()
    private let networkEmptySetView = EBNetworkEmptySetView.instantiateFromXib()

    var viewModel: EBWeatherListViewModel!
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
        title = ""
        _setupTableView()
        _setupTopGradentView()
        _setupBottomGradentView()
        _setupToTopButton()
        _setupEmptySetView()
    }

    private func _setupUITheme() {
        settingButton.tintColor = R.color.background.primary()
        tableView.backgroundColor = .clear
        topGradentView.isUserInteractionEnabled = false
        topGradentView.colors = [R.color.background.background() ?? .clear,
                                 R.color.background.background()?.withAlphaComponent(0.0) ?? .clear]
        bottomGradentView.isUserInteractionEnabled = false
        bottomGradentView.colors = [R.color.background.background()?.withAlphaComponent(0.0) ?? .clear,
                                    R.color.background.background() ?? .clear]
    }

    private func _setupTableView() {
        tableView.register(EBWeatherListItemCell.nib, forCellReuseIdentifier: EBWeatherListItemCell.reuseIdentifier)
        tableView.addSubview(refreshControl)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = 85
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
        listEmptySetView.isHidden = true
        view.addSubview(listEmptySetView)
        listEmptySetView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
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
                self.listEmptySetView.messageLabelText = R.string.localizable.error_message_empty_weather_list.key.localized
            })
            .disposed(by: disposeBag)
    }

    private func _bindUIs() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

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

        let triggerSetting = settingButton.rx.tap.asDriver()

        let triggerViewWillAppear = rx.viewWillAppear.asDriverOnErrorJustComplete().mapToVoid()
        let triggerRefreshControlRefresh = refreshControl.rx.controlEvent(.primaryActionTriggered).asDriver()
        let triggerNetworkEmptySetViewRefresh = networkEmptySetView.triggerRefresh
        let triggerRefresh = Driver.merge(triggerViewWillAppear,
                                          triggerRefreshControlRefresh,
                                          triggerNetworkEmptySetViewRefresh)

        let triggerFooterViewAdd = footerView.triggerAdd
        let triggerEmptySetViewAdd = listEmptySetView.triggerAdd
        let triggerAdd = Driver.merge(triggerFooterViewAdd,
                                      triggerEmptySetViewAdd)

        let triggerItemSelected = tableView.rx.itemSelected
            .asDriver()
            .map { $0.row }

        let triggerItemDeleted = tableView.rx.itemDeleted
            .asDriver()
            .map { $0.row }

        let input = EBWeatherListViewModel.Input(triggerSetting: triggerSetting,
                                                 triggerRefresh: triggerRefresh,
                                                 triggerAdd: triggerAdd,
                                                 triggerItemSelected: triggerItemSelected,
                                                 triggerItemDeleted: triggerItemDeleted)
        let output = viewModel.transform(input)

        output.state
            .filter { $0 != .onDispose }
            .map { $0 != .onError }
            .drive(networkEmptySetView.rx.isHidden)
            .disposed(by: disposeBag)

        output.headerViewModel
            .drive(headerView.viewModel)
            .disposed(by: disposeBag)

        output.headerViewModel
            .map { !$0.isValid }
            .drive(headerView.rx.animated.fade().isHidden)
            .disposed(by: disposeBag)

        output.headerViewModel
            .drive(onNext: { [unowned self] headerViewModel in
                if headerViewModel.isValid {
                    self.tableView.tableHeaderView = self.headerView
                } else {
                    self.tableView.tableHeaderView = nil
                }
            })
            .disposed(by: disposeBag)

        output.cellModels
            .drive(tableView.rx.items) { tableView, row, item in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: EBWeatherListItemCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: item)
                return cell
            }
            .disposed(by: disposeBag)

        Driver.combineLatest(output.headerViewModel, output.cellModels)
            .debug()
            .map { $0.isValid || !$1.isEmpty }
            .drive(listEmptySetView.rx.animated.fade().isHidden)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension EBWeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: R.string.localizable.action_delete.key.localized) { _, indexPath in
            // Handling in rx.itemDeleted
            tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
        }
        deleteButton.backgroundColor = R.color.background.error()
        return [deleteButton]
    }
}
