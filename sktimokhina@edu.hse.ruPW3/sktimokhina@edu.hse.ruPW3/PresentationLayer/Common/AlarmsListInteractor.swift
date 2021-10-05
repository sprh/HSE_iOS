//
//  AlarmsListInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsListInteractor {
    func didTapNewAlarm()
}

final class AlarmsListInteractor: IAlarmsListInteractor {
    let presenter: IAlarmsListPresenter
    let worker: ICoreDataWorker

    init(presenter: IAlarmsListPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func didTapNewAlarm() {
        presenter.shouldShowNewAlarm(with: worker)
    }
}
