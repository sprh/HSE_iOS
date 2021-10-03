//
//  CollectionGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit
import CoreData

final class CollectionGraph {
    private let view: ICollectionVC
    private let interactor: ICollectionInteractor
    private var presenter: ICollectionPresenter
    private let router: ICollectionRouter
    private let worker: ICoreDataWorker

    var viewController: UIViewController {
        view
    }

    init(context: NSManagedObjectContext) {
        presenter = CollectionPresenter()
        worker = CoreDataWorker(context: context)
        interactor = CollectionInteractor(presenter: presenter, worker: worker)
        view = CollectionVC(interactor: interactor)
        router = ColletionViewRouter(viewController: view)
        presenter.viewController = view
    }
}
