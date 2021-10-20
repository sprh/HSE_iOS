//
//  NodesListGraph.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit
import CoreData

final class NodesListGraph {
    private let view: INodesListVC
    private let interactor: INodesListInteractor
    private var presenter: INodesListPresenter
    private var router: INodesListRouter

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker) {
        presenter = NodesListPresenter()
        interactor = NodesListInteractor(presenter: presenter, worker: worker)
        router = NodesListViewRouter()
        view = NodesListVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}
