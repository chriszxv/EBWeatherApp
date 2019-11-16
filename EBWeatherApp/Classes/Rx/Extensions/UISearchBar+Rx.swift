//
//  UISearchBar+Rx.swift
//  AA
//
//  Created by Atkins Leung on 12/7/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift
// MARK: - Observer

public extension Reactive where Base: UISearchBar {
    /// Bindable sink for `placeholder` property
    var placeholder: Binder<String?> {
        return Binder(base) { view, placeholder in
            view.placeholder = placeholder
        }
    }

    /// Bindable sink for `searchField.backgroundColor` property
    var textFieldBackgroundColor: Binder<UIColor?> {
        return Binder(base) { view, backgroundColor in
            view.searchField.backgroundColor = backgroundColor
        }
    }

    /// Bindable sink for `searchField.textColor` property
    var textFieldTextColor: Binder<UIColor?> {
        return Binder(base) { view, textColor in
            view.searchField.textColor = textColor
        }
    }

    /// Bindable sink for `searchField.borderColor` property
    var textFieldBorderColor: Binder<UIColor?> {
        return Binder(base) { view, borderColor in
            view.searchField.borderColor = borderColor
        }
    }

    /// Bindable sink for `searchField.borderWidth` property
    var textFieldBorderWidth: Binder<CGFloat> {
        return Binder(base) { view, borderWidth in
            view.searchField.borderWidth = borderWidth
        }
    }

    /// Bindable sink for `searchField.cornerRadius` property
    var textFieldCornerRadius: Binder<CGFloat> {
        return Binder(base) { view, cornerRadius in
            view.searchField.cornerRadius = cornerRadius
        }
    }

    /// Bindable sink for `searchField.textColor` property
    var textFieldTintColor: Binder<UIColor> {
        return Binder(base) { view, tintColor in
            view.searchField.tintColor = tintColor
        }
    }

    /// Bindable sink for `searchField.leftView` property
    var textFieldIconTintColor: Binder<UIColor> {
        return Binder(base) { view, tintColor in
            let iconImageView = view.searchField.leftView as? UIImageView
            iconImageView?.image = iconImageView?.image?.withRenderingMode(.alwaysTemplate)
            iconImageView?.tintColor = tintColor
        }
    }

    var textFieldKeyboardAppearance: Binder<UIKeyboardAppearance> {
        return Binder(base) { view, appearance in
            view.searchField.keyboardAppearance = appearance
        }
    }
}
