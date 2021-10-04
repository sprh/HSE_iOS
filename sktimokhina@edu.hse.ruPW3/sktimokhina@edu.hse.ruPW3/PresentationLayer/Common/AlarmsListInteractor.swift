//
//  AlarmsListInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsInteractor {
}

final class AlarmsInteractor: IAlarmsInteractor {
    let presenter: IAlarmsPresenter
    let worker: ICoreDataWorker

    init(presenter: IAlarmsPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
