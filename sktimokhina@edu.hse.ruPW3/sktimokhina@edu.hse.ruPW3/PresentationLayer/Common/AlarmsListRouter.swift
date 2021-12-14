//
//  AlarmsListRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

protocol IAlarmsListRouter {
    var viewController: IAlarmsListVC? { get set }

    func shouldShowNewAlarm(with worker: ICoreDataWorker, observer: IAlarmUpdaterObserver)
    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm, observer: IAlarmUpdaterObserver)
    func showError()
}

final class AlarmsListViewRouter: IAlarmsListRouter {
    weak var viewController: IAlarmsListVC?

    func shouldShowNewAlarm(with worker: ICoreDataWorker,
                            observer: IAlarmUpdaterObserver) {
        let graph = NewAlarmGraph(worker: worker, observer: observer)
        viewController?.navigationController?.present(graph.viewController,
                                                      animated: true)
    }

    func shouldShowNewAlarm(with worker: ICoreDataWorker,
                            alarm: Alarm,
                            observer: IAlarmUpdaterObserver) {
        let graph = NewAlarmGraph(worker: worker, alarm: alarm, observer: observer)
        viewController?.navigationController?.present(graph.viewController,
                                                      animated: true)
    }

    func showError() {
        let alert = UIAlertController(title: "Error", message: "Ops, something went wrong(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}

