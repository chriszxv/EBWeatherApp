//
//  EBBaseViewController.swift
//  EBWeatherApp
//
//  Created by product on 15/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

class EBBaseViewController: UIViewController {
    private let disposeBag = DisposeBag()

    deinit {
        print("Deinit: \(String(describing: self))")
    }

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
        _bindUIs()
    }

    private func _bindThemeService() {
        // None
    }

    private func _bindLocaleService() {
        // None
    }

    private func _bindUIs() {
        rx.viewDidAppear
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] _ in
                if UIApplication.shared.statusBarStyle != self.preferredStatusBarStyle {
                    UIView.animate(withDuration: 0.33,
                                   animations: {
                                       self.setNeedsStatusBarAppearanceUpdate()
                    })
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Status Bar

extension EBBaseViewController {
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return ???
//    }
}

// MARK: - Orientation

extension EBBaseViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
