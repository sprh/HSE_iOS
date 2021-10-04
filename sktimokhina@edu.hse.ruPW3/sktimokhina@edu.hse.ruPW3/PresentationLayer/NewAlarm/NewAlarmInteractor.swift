//
//  NewAlarmInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol INewAlarmInteractor {
}

final class NewAlarmInteractor: INewAlarmInteractor {
    let presenter: INewAlarmPresenter
    let worker: ICoreDataWorker

    init(presenter: INewAlarmPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
