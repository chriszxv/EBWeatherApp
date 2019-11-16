//
//  EBWeatherListViewController.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

class EBWeatherListViewController: EBBaseViewController {
    override class var storyboardName: String {
        return "EBWeather"
    }

    @IBOutlet private var settingButton: UIButton!
    @IBOutlet private var tableView: UITableView!

    var viewModel: EBWeatherListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupUIs()
        _setupBindings()
    }

    private func _setupUIs() {
        // None
    }

    private func _setupBindings() {
        _bindThemeService()
        _bindLocaleService()
        _bindViewModel()
    }

    private func _bindThemeService() {
        // None
    }

    private func _bindLocaleService() {
        // None
    }

    private func _bindViewModel() {
        assert(viewModel != nil)

        let triggerSetting = settingButton.rx.tap
            .asDriver()

        let input = EBWeatherListViewModel.Input(triggerSetting: triggerSetting)
        let output = viewModel.transform(input)

        print(output)
    }
}
