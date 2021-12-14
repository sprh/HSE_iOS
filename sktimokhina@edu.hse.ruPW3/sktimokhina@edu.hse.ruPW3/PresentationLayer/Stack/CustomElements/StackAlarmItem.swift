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

    lazy var alarmView: AlarmView = {
        let view = AlarmView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(with alarm: Alarm?, observer: IAlarmUpdaterObserver?) {
        guard let alarm = alarm else { return }
        id = alarm.id
        self.observer = observer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        alarmView.setup(time: dateFormatter.string(from: alarm.time), description: alarm.descriptionText, isOn: alarm.on)
        alarmView.onSwitch.addTarget(self, action: #selector(didToggleIsOn), for: .valueChanged)
        backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        layer.cornerRadius = 20
        addSubview(alarmView)
        NSLayoutConstraint.activate([
            alarmView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alarmView.trailingAnchor.constraint(equalTo: trailingAnchor),
            alarmView.topAnchor.constraint(equalTo: topAnchor),
            alarmView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func update(with alarm: Alarm?) {
        guard let alarm = alarm else { return }
        id = alarm.id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.string(from: alarm.time)
        alarmView.timeLabel.text = dateFormatter.string(from: alarm.time)
        alarmView.onSwitch.isOn = alarm.on
        alarmView.descriptionText.text = alarm.descriptionText
    }

    @objc
    private func didToggleIsOn() {
        observer?.didToggleIsOn(id: id, isOn: alarmView.onSwitch.isOn)
    }
}
