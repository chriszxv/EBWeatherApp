//
//  EBWeatherListViewModel.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBWeatherListViewModel: ViewModelType {
    struct Input {
        let triggerSetting: Driver<Void>
    }

    struct Output {
//        let ???: Driver<Void>
    }

    private let navigator: EBWeatherListNavigator
    private let disposeBag = DisposeBag()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(navigator: EBWeatherListNavigator) {
        self.navigator = navigator
    }

    func transform(_ input: Input) -> Output {
        // Input
        input.triggerSetting
            .drive(onNext: navigator.showSetting)
            .disposed(by: disposeBag)

        // Output
        return Output()
    }
}
