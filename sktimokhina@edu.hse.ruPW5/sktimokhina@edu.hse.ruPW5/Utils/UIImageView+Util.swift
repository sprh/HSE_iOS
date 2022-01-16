//
//  UIImageView+Util.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 10.11.2021.
//

import UIKit

extension UIImageView {
    func startShimmeringAnimation() {
        let light = UIColor.white.cgColor
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: -bounds.size.width,
                                y: 0,
                                width: 3 * bounds.size.width,
                                height: bounds.size.height)
        gradient.colors = [light, 1, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.525)
        gradient.locations = [0.3, 0.6]
        layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 2
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmeringAnimation() {
        layer.mask = nil
    }
}
