//
//  UIFont+Util.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

import UIKit

extension UIFont {
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    func setBold() -> UIFont {
        if(isBold) {
            return self
        }
        else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitBold])
            guard let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry) else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails, size: 0)
        }
    }
}
