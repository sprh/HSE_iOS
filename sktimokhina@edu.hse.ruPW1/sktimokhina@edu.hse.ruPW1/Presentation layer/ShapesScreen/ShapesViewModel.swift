//
//  ShapesViewModel.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

final class ShapesViewModel: UIView {
    private var updateViewButton: UIButton = {
        let buttonViewModel = MainButton.ViewModel(font: .buttonFont,
                                                    title: "Tap me",
                                                    enabledBackgroundColor: .button,
                                                    disabledBackgroundColor: .disabledButton,
                                                    enabledTextColor: .text,
                                                    disabledTextColor: .text,
                                                    cornerRadius: 23)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()

    func setup() {
        backgroundColor = .background
        setupUI()
    }

    func setupUI() {
        addSubview(updateViewButton)
        NSLayoutConstraint.activate([
            updateViewButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            updateViewButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            updateViewButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            updateViewButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
