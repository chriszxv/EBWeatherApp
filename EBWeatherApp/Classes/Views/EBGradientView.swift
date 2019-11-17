//
//  EBGradientView.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBGradientView: UIView {
    var colors: [UIColor]? = [] {
        didSet {
            let gradientLayer = layer as! CAGradientLayer
            if let colors = colors {
                gradientLayer.colors = colors.map { $0.cgColor }
            } else {
                gradientLayer.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
            }
        }
    }

    var locations: [NSNumber]? {
        didSet {
            let gradientLayer = layer as! CAGradientLayer
            gradientLayer.locations = locations
        }
    }

    var startPoint: CGPoint? {
        didSet {
            let gradientLayer = layer as! CAGradientLayer
            gradientLayer.startPoint = startPoint ?? CGPoint(x: 0.5, y: 0)
        }
    }

    var endPoint: CGPoint? {
        didSet {
            let gradientLayer = layer as! CAGradientLayer
            gradientLayer.endPoint = endPoint ?? CGPoint(x: 0.5, y: 1)
        }
    }

    var type: CAGradientLayerType? {
        didSet {
            let gradientLayer = layer as! CAGradientLayer
            gradientLayer.type = type ?? .axial
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

// MARK: - Observer

extension Reactive where Base: EBGradientView {
    /// Bindable sink for `colors` property
    var colors: Binder<[UIColor]?> {
        return Binder(base) { view, colors in
            view.colors = colors
        }
    }
}
