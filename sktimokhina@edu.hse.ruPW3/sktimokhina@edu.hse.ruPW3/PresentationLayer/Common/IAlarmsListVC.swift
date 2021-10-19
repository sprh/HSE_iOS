//
//  IAlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

protocol IAlarmsListVC: UIViewController, IAlarmUpdaterObserver {
    var interactor: IAlarmsListInteractor { get }
    var router: IAlarmsListRouter { get }
    func shouldShowNewAlarm(with worker: ICoreDataWorker)
    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm)

    func setAlarms()
    func showError()
    func didUpdateItem(with id: ObjectIdentifier)
}

extension IAlarmsListVC {
    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        router.shouldShowNewAlarm(with: worker, observer: self)
    }

    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm) {
        router.shouldShowNewAlarm(with: worker, alarm: alarm, observer: self)
    }
}
