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
}

final class AlarmsListViewRouter: IAlarmsListRouter {
    weak var viewController: IAlarmsListVC?

    func shouldShowNewAlarm(with worker: ICoreDataWorker) {
        let graph = NewAlarmGraph(worker: worker)
        viewController?.navigationController?.present(graph.viewController,
                                                      animated: true)
    }
}

