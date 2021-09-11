//
//  UIView+Utils.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

extension UIView {
    static var topSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }

    static var bottomSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }

    static var leftSafeAreaWidth: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.left ?? 0
    }

    static var rightSafeAreaWidth: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.right ?? 0
    }
}

