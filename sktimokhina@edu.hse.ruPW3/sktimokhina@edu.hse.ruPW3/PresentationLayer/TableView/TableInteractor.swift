//
//  TableInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ITableInteractor {
}

final class TableInteractor: ITableInteractor {
    let presenter: ITablePresenter
    let worker: ITableWorker

    init(presenter: ITablePresenter, worker: ITableWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
