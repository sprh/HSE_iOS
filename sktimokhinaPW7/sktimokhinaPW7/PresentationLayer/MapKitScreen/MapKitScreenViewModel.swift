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
            routeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
