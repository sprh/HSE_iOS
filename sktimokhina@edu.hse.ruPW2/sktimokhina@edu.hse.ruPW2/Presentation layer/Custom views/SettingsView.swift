//
//  SettingsView.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 18.09.2021.
//

import UIKit

final class SettingsView: UIStackView {
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }

    private func createSlider(with tintColor: UIColor) -> UISlider {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = tintColor
        slider.tintColor = tintColor
        slider.minimumValue = 0
        slider.maximumValue = 255
        return slider
    }

    var locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.translatesAutoresizingMaskIntoConstraints = false
        return locationSwitch
    }()

    var redColorSlider: UISlider!
    var greenColorSlider: UISlider!
    var blueColorSlider: UISlider!

    override init(frame: CGRect) {
        super.init(frame: frame)
        redColorSlider = createSlider(with: .red)
        greenColorSlider = createSlider(with: .green)
        blueColorSlider = createSlider(with: .blue)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let locationLabel = createLabel(with: "Location")
        let redColorLabel = createLabel(with: "Red")
        let greenColorLabel = createLabel(with: "Green")
        let blueColorLabel = createLabel(with: "Blue")
        addSubview(locationLabel)
        addSubview(redColorLabel)
        addSubview(greenColorLabel)
        addSubview(blueColorLabel)
        addSubview(locationSwitch)
        addSubview(redColorSlider)
        addSubview(greenColorSlider)
        addSubview(blueColorSlider)


        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: topAnchor),
            locationSwitch.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationSwitch.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),

            redColorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            redColorLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            redColorSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            redColorSlider.centerYAnchor.constraint(equalTo: redColorLabel.centerYAnchor),
            redColorSlider.leadingAnchor.constraint(equalTo: greenColorLabel.trailingAnchor, constant: 16),

            greenColorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenColorLabel.topAnchor.constraint(equalTo: redColorLabel.bottomAnchor, constant: 16),
            greenColorSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenColorSlider.centerYAnchor.constraint(equalTo: greenColorLabel.centerYAnchor),
            greenColorSlider.widthAnchor.constraint(equalTo: redColorSlider.widthAnchor),

            blueColorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            blueColorLabel.topAnchor.constraint(equalTo: greenColorLabel.bottomAnchor, constant: 16),
            blueColorSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            blueColorSlider.centerYAnchor.constraint(equalTo: blueColorLabel.centerYAnchor),
            blueColorSlider.widthAnchor.constraint(equalTo: redColorSlider.widthAnchor),
            blueColorSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}
