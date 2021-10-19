//
//  AlarmView.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

final class AlarmView: UIView {
    lazy var onSwitch: UISwitch = {
        let onSwitch = UISwitch()
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        onSwitch.onTintColor = .systemOrange
        return onSwitch
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        return label
    }()

    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 3
        return label
    }()

    func setup(time: String, description: String?, isOn: Bool) {
        timeLabel.text = time
        descriptionText.text = description
        onSwitch.isOn = isOn
        addSubview(onSwitch)
        addSubview(timeLabel)
        addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            onSwitch.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            onSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

}
