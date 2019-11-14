//
//  UIScrollView+AA.swift
//  AA
//
//  Created by Chris So on 6/8/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

import UIKit

extension UIScrollView {
    @objc func scrollToTop() {
        setContentOffset(CGPoint.zero, animated: true)
    }

    func scrollToBottom() {
        let y = contentSize.height - frame.size.height
        setContentOffset(CGPoint(x: 0, y: y < 0 ? 0 : y), animated: true)
    }
}
