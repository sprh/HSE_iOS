//
//  ShapesViewController.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

/// A view controller with shapres.
final class ShapesViewController: UIViewController {
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

    private var shapeButtons: [ShapeButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupUI()
        setupShapesButtons()
    }

    private func setupUI() {
        view.addSubview(updateViewButton)
        NSLayoutConstraint.activate([
            updateViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            updateViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            updateViewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            updateViewButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    private func setupShapesButtons() {
        for _ in 0..<Int.random(in: 6..<10) {
            let shapeButton = ShapeButton(viewModel: generateRandomShapeButtonViewModel())
            view.addSubview(shapeButton)
            shapeButtons.append(shapeButton)
        }
    }

    private func generateRandomShapeButtonViewModel() -> ShapeButton.ViewModel {
        let bottomPadding = UIView.bottomSafeAreaHeight + 75
        let maxHeight = view.frame.height - UIView.topSafeAreaHeight - bottomPadding
        let maxWidth = view.frame.width - UIView.leftSafeAreaWidth - UIView.rightSafeAreaWidth
        let height = CGFloat.random(in: maxHeight / 10...maxHeight / 3)
        let width = CGFloat.random(in: maxWidth / 10...maxWidth / 3)
        let x = CGFloat.random(in: UIView.leftSafeAreaWidth...max(UIView.leftSafeAreaWidth, maxWidth - width))
        let y = CGFloat.random(in: UIView.topSafeAreaHeight...max(UIView.topSafeAreaHeight, maxHeight - height * 2))
        let cornerRadius = CGFloat.random(in: 2..<50)
        return ShapeButton.ViewModel(height: height,
                                     width: width,
                                     x: x,
                                     y: y,
                                     cornerRadius: cornerRadius,
                                     backgroundColor: generateRandomHexColor())
    }

    private func generateRandomHexColor() -> String {
        let validValues = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
        var result = ["#"]
        for _ in 0..<6 {
            result.append(validValues[Int(arc4random_uniform(15))])
        }
        return result.joined()
    }
}
