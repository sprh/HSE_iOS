//
//  AlarmCollectionViewCell.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class AlarmCollectionViewCell: UICollectionViewCell {
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
        contentView.addSubview(onSwitch)
        contentView.addSubview(timeLabel)
        contentView.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            onSwitch.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            onSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    @objc
    private func didToggleIsOn() {
        observer?.didToggleIsOn(id: id, isOn: onSwitch.isOn)
    }
}
