//
//  CollectionGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class CollectionGraph {
    private let view: ICollectionVC
    private let interactor: ICollectionInteractor
    private var presenter: ICollectionPresenter
    private let router: ICollectionRouter
    private let worker: ICollectionWorker

    var viewController: UIViewController {
        view
    }

    init() {
        presenter = CollectionPresenter()
        worker = CollectionWorker()
        interactor = CollectionInteractor(presenter: presenter, worker: worker)
        view = CollectionVC(interactor: interactor)
        router = ColletionViewRouter(viewController: view)
        presenter.viewController = view
    }
}
