//
//  EBScrollStackView.swift
//  EBWeatherApp
//
//  Created by product on 18/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import UIKit

final class EBScrollStackView: UIView {
    let scrollView = UIScrollView()
    let containerView = UIView()
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUIs()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupUIs()
    }

    private func _setupUIs() {
        _setupUITheme()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10.0

        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(5)
            make.left.equalTo(containerView).offset(5)
            make.bottom.equalTo(containerView).offset(-5)
            make.right.equalTo(containerView).offset(-5)
        }
    }

    private func _setupUITheme() {
        // None
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
