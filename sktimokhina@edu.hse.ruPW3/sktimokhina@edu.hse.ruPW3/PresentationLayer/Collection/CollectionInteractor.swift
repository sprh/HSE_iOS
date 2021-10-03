//
//  CollectionInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ICollectionInteractor {
}

final class CollectionInteractor: ICollectionInteractor {
    let presenter: ICollectionPresenter
    let worker: ICoreDataWorker

    init(presenter: ICollectionPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
