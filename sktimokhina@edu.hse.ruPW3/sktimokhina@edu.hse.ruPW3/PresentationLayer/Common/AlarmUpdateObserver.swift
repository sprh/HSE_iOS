//
//  AlarmUpdateObserver.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 11.10.2021.
//

protocol IAlarmUpdaterObserver: AnyObject {
    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool)
    func didAddItem()
    func didUpdateItem(with id: ObjectIdentifier)
    func didDeleteItem()
}
