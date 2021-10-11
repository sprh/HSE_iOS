//
//  AlarmsListPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsListPresenter {
    var viewController: IAlarmsListVC? { get set }

    func shouldShowNewAlarm(with worker: ICoreDataWorker)
    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm)
    func setAlarms()
    func showError()
    func didUpdateAlarm(with id: ObjectIdentifier)
}

final class AlarmsListPresenter: IAlarmsListPresenter {
    weak var viewController: IAlarmsListVC?

    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        viewController?.shouldShowNewAlarm(with: worker)
    }

    func setAlarms() {
        viewController?.setAlarms()
    }

    func showError() {
        viewController?.showError()
    }

    func didUpdateAlarm(with id: ObjectIdentifier) {

    }

    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm) {
        viewController?.shouldShowNewAlarm(with: worker, alarm: alarm)
    }
}
