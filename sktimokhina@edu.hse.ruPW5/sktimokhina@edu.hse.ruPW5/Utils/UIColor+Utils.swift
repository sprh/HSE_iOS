//
//  UIColor+Util.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

import UIKit

extension UIColor {
    static var background: UIColor {
        UIColor(named: "backgroundColor")!
    }

    static var subviewBackground: UIColor {
        UIColor(named: "subviewBackgroundColor")!
    }

    static var text: UIColor {
        return UIColor(named: "textColor")!
    }

    static var loadingImageBackground: UIColor {
        UIColor(named: "loadingImageBackgroundColor")!
    }
}
