//
//  AlarmsListPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsPresenter {
    var viewController: IAlarmsVC? { get set }

    func shouldShowNewAlarm(with worker: ICoreDataWorker)
}

final class AlarmsPresenter: IAlarmsPresenter {
    weak var viewController: IAlarmsVC?

    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        viewController?.shouldShowNewAlarm(with: worker)
    }
}
