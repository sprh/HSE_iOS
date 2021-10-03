//
//  UIButton+Utils.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

extension UIButton {
    /// An objc methon that animate a button.
    ///
    /// Can be added in the init:
    /// ```
    /// addTarget(self, action: #selector(onPress), for: .touchUpInside)
    /// ```
    @objc func onPress() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            self?.alpha = 0.8
        }, completion: {[weak self] finished in
            if finished {
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self?.alpha = 1
            }
        })
    }
}
