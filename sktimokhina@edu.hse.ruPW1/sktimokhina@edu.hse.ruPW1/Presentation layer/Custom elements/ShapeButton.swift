//
//  ShapeButton.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

final class ShapeButton: UIButton {
    struct ViewModel {
        let frame: CGRect
        let cornerRadius: CGFloat
        let backgroundColor: String

        init(height: CGFloat, width: CGFloat, x: CGFloat, y: CGFloat, cornerRadius: CGFloat, backgroundColor: String) {
            frame = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
            self.cornerRadius = cornerRadius
            self.backgroundColor = backgroundColor
        }
    }

    init(viewModel: ViewModel) {
        super.init(frame: viewModel.frame)
        addTarget(self, action: #selector(onPress), for: .touchUpInside)
        configurate(with: viewModel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configurate(with viewModel: ViewModel) {
        layer.cornerRadius = viewModel.cornerRadius
        frame = viewModel.frame
        backgroundColor = .black
    }
}
