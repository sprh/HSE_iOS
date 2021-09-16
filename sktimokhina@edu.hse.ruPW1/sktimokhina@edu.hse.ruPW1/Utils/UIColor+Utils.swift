//
//  UIColor+Utils.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

extension UIColor {
    // Static vars (colors from assets).
    static var background: UIColor {
        UIColor(named: "background")!
    }

    static var text: UIColor {
        UIColor(named: "text")!
    }

    static var button: UIColor {
        UIColor(named: "button")!
    }

    static var disabledButton: UIColor {
        UIColor(named: "disabledButton")!
    }

    static var tabBarTint: UIColor {
        UIColor(named: "tabBarTint")!
    }

    /// Returns color from a hex string.
    static func colorWithHexString(hexString: String) -> UIColor {
        if !hexString.starts(with: "#") || hexString.count != 7 {
            return UIColor.clear
        }
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
        let red: CGFloat = colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = colorComponentFrom(colorString: colorString, start: 4, length: 2)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        return color
    }

    /// Returns color component from a substring
    static func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt64 = 0
        guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        return floatValue
    }
}
