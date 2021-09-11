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
        updateViewButton.addTarget(self, action: #selector(updateShapeButtonsViewModels), for: .touchUpInside)
    }

    private func setupShapesButtons() {
        for _ in 0..<Int.random(in: 6..<10) {
            let shapeButton = ShapeButton(viewModel: generateRandomShapeButtonViewModel())
            view.addSubview(shapeButton)
            shapeButtons.append(shapeButton)
        }
    }

    @objc
    func updateShapeButtonsViewModels() {
        updateViewButton.isEnabled = false
        UIView.animate(withDuration: 0.9, animations: { [weak self] in
            guard let self = self else { return }
            self.shapeButtons.forEach({$0.configurate(with: self.generateRandomShapeButtonViewModel())})
        }, completion: { [weak self] finished in
            self?.updateViewButton.isEnabled = finished
        })
    }

    /// Method to generate a random shape button view model.
    /// There are some calculations because we don't want to go beyond the screen.
    private func generateRandomShapeButtonViewModel() -> ShapeButton.ViewModel {
        let bottomPadding = UIView.bottomSafeAreaHeight + 90
        let topPadding = UIView.topSafeAreaHeight
        let leftPadding = UIView.leftSafeAreaWidth
        let rightPadding = UIView.rightSafeAreaWidth
        let maxHeight = view.frame.height - topPadding - bottomPadding
        let maxWidth = view.frame.width - leftPadding - rightPadding
        let height = CGFloat.random(in: maxHeight / 6...maxHeight / 2)
        let width = CGFloat.random(in: maxWidth / 6...maxWidth / 2)
        let x = CGFloat.random(in: leftPadding...max(leftPadding, view.frame.width - width - rightPadding))
        let y = CGFloat.random(in: topPadding...max(rightPadding, view.frame.height - height - bottomPadding))
        let cornerRadius = CGFloat.random(in: 2..<50)
        return ShapeButton.ViewModel(height: height,
                                     width: width,
                                     x: x,
                                     y: y,
                                     cornerRadius: cornerRadius,
                                     backgroundColor: generateRandomHexColor())
    }

    /// Returns a random hex string.
    private func generateRandomHexColor() -> String {
        let validValues = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
        var result = ["#"]
        for _ in 0..<6 {
            result.append(validValues[Int(arc4random_uniform(15))])
        }
        return result.joined()
    }
}
