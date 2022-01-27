//
//  MapKitScreenViewModel.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 26.01.2022.
//

import UIKit
import YandexMapsMobile

class MapKitScreenViewModel: UIView {
    lazy var mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.frame = frame
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        return mapView
    }()

    lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "From"
        textField.becomeFirstResponder()
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "To"
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var clearButton: UIButton = {
        let buttonViewModel = MainButton.ViewModel(font: .preferredFont(forTextStyle: .body),
                                                   title: "Clear",
                                                   enabledBackgroundColor: .systemYellow,
                                                   disabledBackgroundColor: .gray,
                                                   enabledTextColor: .black,
                                                   disabledTextColor: .black)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isEnabled = false
        button.layer.cornerRadius = 10
        return button
    }()

    lazy var goButton: UIButton = {
        let buttonViewModel = MainButton.ViewModel(font: .preferredFont(forTextStyle: .body),
                                                   title: "Go",
                                                   enabledBackgroundColor: .systemOrange,
                                                   disabledBackgroundColor: .gray,
                                                   enabledTextColor: .black,
                                                   disabledTextColor: .black)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isEnabled = false
        button.layer.cornerRadius = 10
        return button
    }()

    lazy var routeTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["car", "bicycle", "walk"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemYellow
        return segmentedControl
    }()

    lazy var routeLenght: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemYellow
        return view
    }()

    lazy var routeLenghtText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "test"
        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .yellow
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return button
    }()

    lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus.circle.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .yellow
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return button
    }()


    lazy var compassButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "safari.fill"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .yellow
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(mapView)
        addSubview(fromTextField)
        addSubview(toTextField)
        addSubview(clearButton)
        addSubview(goButton)
        addSubview(routeTypeSegmentedControl)
        addSubview(routeLenght)
        addSubview(plusButton)
        addSubview(minusButton)
        addSubview(compassButton)
        routeLenght.addSubview(routeLenghtText)

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            fromTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fromTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fromTextField.heightAnchor.constraint(equalToConstant: 30),

            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 16),
            toTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            toTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 30),

            goButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            goButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16),
            goButton.heightAnchor.constraint(equalToConstant: 30),

            clearButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            clearButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            clearButton.heightAnchor.constraint(equalToConstant: 30),

            routeTypeSegmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            routeTypeSegmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            routeTypeSegmentedControl.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -16),
            routeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 30),

            routeLenghtText.leadingAnchor.constraint(equalTo: routeLenght.leadingAnchor, constant: 6),
            routeLenghtText.trailingAnchor.constraint(equalTo: routeLenght.trailingAnchor, constant: -6),
            routeLenghtText.topAnchor.constraint(equalTo: routeLenght.topAnchor, constant: 6),
            routeLenghtText.bottomAnchor.constraint(equalTo: routeLenght.bottomAnchor, constant: -6),

            routeLenght.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            routeLenght.bottomAnchor.constraint(equalTo: routeTypeSegmentedControl.topAnchor, constant: -10),

            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            plusButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 20),

            minusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            minusButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -20),

            compassButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            compassButton.bottomAnchor.constraint(equalTo: routeTypeSegmentedControl.topAnchor, constant: -20),
        ])
    }
}
