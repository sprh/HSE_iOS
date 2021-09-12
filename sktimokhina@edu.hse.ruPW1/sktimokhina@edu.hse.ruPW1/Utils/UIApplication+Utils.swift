//
//  UIApplication+Utils.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 12.09.2021.
//

import UIKit

extension UIApplication {
    static var orientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
}
