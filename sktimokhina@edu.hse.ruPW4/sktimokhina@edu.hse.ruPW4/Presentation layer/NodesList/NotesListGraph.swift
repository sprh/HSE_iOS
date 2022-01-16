//
//  NotesListGraph.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit
import CoreData

final class NotesListGraph {
    private let view: INotesListVC
    private let interactor: INotesListInteractor
    private var presenter: INotesListPresenter
    private var router: INotesListRouter

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker, parentNote: Note?) {
        presenter = NotesListPresenter()
        interactor = NotesListInteractor(presenter: presenter, worker: worker, parentNote: parentNote)
        router = NotesListRouter()
        view = NotesListVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}
