//
//  IAlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

protocol IAlarmsListVC: UIViewController {
    var interactor: IAlarmsListInteractor { get }
    var router: IAlarmsListRouter { get }
    func shouldShowNewAlarm(with worker: ICoreDataWorker)

    func setAlarms()
    func showError()
    func didUpdateAlarm(with id: ObjectIdentifier)
}

extension IAlarmsListVC {
    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        router.shouldShowNewAlarm(with: worker)
    }
}
