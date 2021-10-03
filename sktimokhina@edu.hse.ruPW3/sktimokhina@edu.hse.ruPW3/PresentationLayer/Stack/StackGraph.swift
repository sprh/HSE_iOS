//
//  StackGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit
import CoreData

final class StackGraph {
    private let view: IStackVC
    private let interactor: IStackInteractor
    private var presenter: IStackPresenter
    private let router: IStackRouter
    private let worker: ICoreDataWorker

    var viewController: UIViewController {
        view
    }

    init(context: NSManagedObjectContext) {
        presenter = StackPresenter()
        worker = CoreDataWorker(context: context)
        interactor = StackInteractor(presenter: presenter, worker: worker)
        view = StackVC(interactor: interactor)
        router = StackViewRouter(viewController: view)
        presenter.viewController = view
    }
}
