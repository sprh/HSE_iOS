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
    let worker: ICollectionWorker

    init(presenter: ICollectionPresenter, worker: ICollectionWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}
