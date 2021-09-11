//
//  MainButton.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

final class MainButton: UIButton {
    struct ViewModel {
        let font: UIFont
        let title: String?
        let enabledBackgroundColor: UIColor
        let disabledBackgroundColor: UIColor
        let enabledTextColor: UIColor
        let disabledTextColor: UIColor
        let cornerRadius: CGFloat
    }

    private var enabledBackgroundColor: UIColor!
    private var disabledBackgroundColor: UIColor!
    private var enabledTextColor: UIColor!
    private var disabledTextColor: UIColor!

    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            if isEnabled {
                backgroundColor = enabledBackgroundColor
                setTitleColor(enabledTextColor, for: .normal)
            } else {
                backgroundColor = disabledBackgroundColor
                setTitleColor(disabledTextColor, for: .normal)
            }

        }

    }
    init(frame: CGRect = .zero, viewModel: ViewModel) {
        super.init(frame: frame)
        configurate(with: viewModel)
    }

    private func configurate(with viewModel: ViewModel) {
        setTitle(viewModel.title, for: .normal)
        titleLabel?.font = viewModel.font
        layer.cornerRadius = viewModel.cornerRadius
        enabledTextColor = viewModel.enabledTextColor
        disabledTextColor = viewModel.disabledTextColor
        enabledBackgroundColor = viewModel.enabledBackgroundColor
        disabledBackgroundColor = viewModel.disabledBackgroundColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
