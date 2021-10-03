//
//  ClockCell.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class ClockCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        label.text = "a"
        return label
    }()

    private func setup() {
        backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        layer.cornerRadius = 20
        addSubview(onSwitch)
        addSubview(timeLabel)

        NSLayoutConstraint.activate([
            onSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            onSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
