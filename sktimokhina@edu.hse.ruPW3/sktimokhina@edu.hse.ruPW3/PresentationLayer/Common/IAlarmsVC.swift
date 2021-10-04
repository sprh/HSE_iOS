//
//  IAlarmsVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

protocol IAlarmsVC: UIViewController {
    var interactor: IAlarmsInteractor { get }
    var router: IAlarmsRouter { get }
    func shouldShowNewAlarm(with worker: ICoreDataWorker)
}

extension IAlarmsVC {
    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        router.shouldShowNewAlarm(with: worker)
    }
}
