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
        // Background color if isEnabled = true
        let enabledBackgroundColor: UIColor
        // Background color if isEnabled = false
        let disabledBackgroundColor: UIColor
        // Text color if isEnabled = true
        let enabledTextColor: UIColor
        // Text color if isEnabled = false
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
        addTarget(self, action: #selector(onPress), for: .touchUpInside)
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
