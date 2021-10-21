//
//  CreateNodeGraph.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit
import CoreData

final class CreateNodeGraph {
    private let view: ICreateNodeVC
    private let interactor: ICreateNodeInteractor
    private var presenter: ICreateNodePresenter
    private var router: ICreateNodeRouter

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker, observer: ICreateNodeViewObserver?) {
        presenter = CreateNodePresenter()
        interactor = CreateNodeInteractor(presenter: presenter, worker: worker, observer: observer)
        router = CreateNodeViewRouter()
        view = CreateNodeVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}
