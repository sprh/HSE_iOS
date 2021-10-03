//
//  StackInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol IStackInteractor {
}

final class StackInteractor: IStackInteractor {
    let presenter: IStackPresenter
    let worker: IStackWorker

    init(presenter: IStackPresenter, worker: IStackWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
