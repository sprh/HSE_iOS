//
//  AlarmsListGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

final class AlarmsListGraph {
    enum `Type` {
        case table
        case collection
        case stack
    }

    private let view: IAlarmsVC
    private let interactor: IAlarmsInteractor
    private var presenter: IAlarmsPresenter
    private var router: IAlarmsRouter
    private let worker: ICoreDataWorker
    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker, type: Type) {
        presenter = AlarmsPresenter()
        self.worker = worker
        interactor = AlarmsInteractor(presenter: presenter, worker: worker)
        router = AlarmsViewRouter()
        switch type {
        case .table:
            view = TableVC(interactor: interactor, router: router)
        case .collection:
            view = CollectionVC(interactor: interactor, router: router)
        case .stack:
            view = StackVC(interactor: interactor, router: router)
        }
        router.viewController = view
        presenter.viewController = view
    }
}
