//
//  ColorSlider.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 18.09.2021.
//

import UIKit

final class ColorSlider: UISlider {
    enum Color {
        case red
        case green
        case blue
    }

    let color: Color

    init(frame: CGRect, color: Color) {
        self.color = color
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        var mainColor: UIColor
        switch color {
        case .red:
            mainColor = .red
        case .green:
            mainColor = .green
        case .blue:
            mainColor = .blue
        }
        tintColor = mainColor
        thumbTintColor = mainColor
    }
}
