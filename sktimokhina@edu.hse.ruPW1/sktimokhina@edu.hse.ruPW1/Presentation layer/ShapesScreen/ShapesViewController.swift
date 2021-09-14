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
        let buttonViewModel = MainButton.ViewModel(font: UIFont.preferredFont(forTextStyle: .headline),
                                                   title: "Tap me",
                                                   enabledBackgroundColor: .button,
                                                   disabledBackgroundColor: .disabledButton,
                                                   enabledTextColor: .text,
                                                   disabledTextColor: .text)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isEnabled = true
        button.autoresizingMask = .flexibleHeight
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        button.addTarget(self, action: #selector(updateShapeButtonViewModels), for: .touchUpInside)
        return button
    }()

    private var shapeButtons: [ShapeButton] = []
    /// A state that has a previous orientation state.
    private var previousOrientation: UIInterfaceOrientation?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribing on the orientationDidChangeNotification.
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation),
                                               name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Unsubscribing.
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        previousOrientation = UIApplication.orientation
        view.backgroundColor = .background
        setupUI()
        setupShapesButtons()
    }

    /// UI settaping.
    /// Adding an updateViewButton and constraints.
    private func setupUI() {
        view.addSubview(updateViewButton)
        NSLayoutConstraint.activate([
            updateViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            updateViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            updateViewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    /// Generating shapes buttons (with a random count from 6 to 10) add it to the screen.
    private func setupShapesButtons() {
        for _ in 0..<Int.random(in: 6..<10) {
            let shapeButton = ShapeButton(viewModel: generateRandomShapeButtonViewModel())
            shapeButton.addTarget(self, action: #selector(updateShapeButtonViewModel(_:)), for: .touchUpInside)
            view.addSubview(shapeButton)
            shapeButtons.append(shapeButton)
        }
    }

    /// Checking is an orientation was changed.
    @objc
    func didChangeOrientation() {
        let currentOrientation = UIApplication.orientation
        if currentOrientation != previousOrientation {
            updateShapeButtonViewModels()
        }
        previousOrientation = currentOrientation
    }

    /// Apdating a view model for all shape buttons.
    /// It works after someone clicks on the updateViewButton.
    @objc
    private func updateShapeButtonViewModels() {
        updateViewButton.isEnabled = false
        UIView.animate(withDuration: 0.9, delay: 0, options: [.curveLinear], animations: { [weak self] in
            guard let self = self else { return }
            self.shapeButtons.forEach({$0.configurate(with: self.generateRandomShapeButtonViewModel())})
        }, completion: { [weak self] finished in
            self?.updateViewButton.isEnabled = finished
        })
    }

    /// Apdating a view model for the sender (shape button).
    /// It works after someone clicks on any shape button.
    @objc
    private func updateShapeButtonViewModel(_ sender: ShapeButton) {
        updateViewButton.isEnabled = false
        UIView.animate(withDuration: 0.9, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let self = self else { return }
            sender.configurate(with: self.generateRandomShapeButtonViewModel())
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
        let cornerRadius = CGFloat.random(in: 2..<(height + width) / 4)
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
