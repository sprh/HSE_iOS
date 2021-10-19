//
//  StackAlarmItem.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 12.10.2021.
//

import UIKit

final class StackAlarmItem: UIButton {
    var id: ObjectIdentifier!
    weak var observer: IAlarmUpdaterObserver?
    lazy var onSwitch: UISwitch = {
        let onSwitch = UISwitch()
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        onSwitch.onTintColor = .systemOrange
        onSwitch.addTarget(self, action: #selector(didToggleIsOn), for: .valueChanged)
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

    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    func setup(with alarm: Alarm?, observer: IAlarmUpdaterObserver?) {
        guard let alarm = alarm else { return }
        id = alarm.id
        self.observer = observer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.string(from: alarm.time)
        timeLabel.text = dateFormatter.string(from: alarm.time)
        onSwitch.isOn = alarm.on
        descriptionText.text = alarm.descriptionText
        backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        layer.cornerRadius = 20
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

    func update(with alarm: Alarm?) {
        guard let alarm = alarm else { return }
        id = alarm.id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.string(from: alarm.time)
        timeLabel.text = dateFormatter.string(from: alarm.time)
        onSwitch.isOn = alarm.on
        descriptionText.text = alarm.descriptionText
    }

    @objc
    private func didToggleIsOn() {
        observer?.didToggleIsOn(id: id, isOn: onSwitch.isOn)
    }
}
