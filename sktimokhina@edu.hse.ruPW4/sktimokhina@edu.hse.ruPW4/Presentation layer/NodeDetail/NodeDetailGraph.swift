//
//  NodeDetailGraph.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit
import CoreData

final class NodeDetailGraph {
    private let view: INodeDetailVC
    private let interactor: INodeDetailInteractor
    private var presenter: INodeDetailPresenter
    private var router: INodeDetailRouter

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker, observer: INodeDetailViewObserver?) {
        presenter = NodeDetailPresenter()
        interactor = NodeDetailInteractor(presenter: presenter, worker: worker, observer: observer)
        router = NodeDetailViewRouter()
        view = NodeDetailVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}
