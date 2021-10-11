//
//  AlarmsListRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

protocol IAlarmsListRouter {
    var viewController: IAlarmsListVC? { get set }

    func shouldShowNewAlarm(with worker: ICoreDataWorker)
    func shouldShowNewAlarm(with worker: ICoreDataWorker, alarm: Alarm, observer: IAlarmUpdaterObserver)
}

final class AlarmsListViewRouter: IAlarmsListRouter {
    weak var viewController: IAlarmsListVC?

    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        let graph = NewAlarmGraph(worker: worker)
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
}

