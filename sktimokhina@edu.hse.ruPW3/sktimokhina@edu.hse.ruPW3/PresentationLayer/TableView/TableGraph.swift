//
//  TableGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit
import CoreData

final class TableGraph {
    private let view: ITableVC
    private let interactor: ITableInteractor
    private var presenter: ITablePresenter
    private let router: ITableRouter
    private let worker: ICoreDataWorker

    var viewController: UIViewController {
        view
    }

    init(context: NSManagedObjectContext) {
        presenter = TablePresenter()
        worker = CoreDataWorker(context: context)
        interactor = TableInteractor(presenter: presenter, worker: worker)
        view = TableVC(interactor: interactor)
        router = TableViewRouter(viewController: view)
        presenter.viewController = view
    }
}
