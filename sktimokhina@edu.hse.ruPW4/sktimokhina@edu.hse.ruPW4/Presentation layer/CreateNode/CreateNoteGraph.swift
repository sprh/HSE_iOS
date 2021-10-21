//
//  CreateNoteGraph.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit
import CoreData

final class CreateNoteGraph {
    private let view: ICreateNoteVC
    private let interactor: ICreateNoteInteractor
    private var presenter: ICreateNotePresenter
    private var router: ICreateNoteRouter

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker,
         observer: ICreateNoteViewObserver?,
         parentNote: Note?,
         noteToEdit: Note?) {
        presenter = CreateNotePresenter()
        interactor = CreateNoteInteractor(presenter: presenter,
                                          worker: worker,
                                          observer: observer,
                                          parentNote: parentNote,
                                          noteToEdit: noteToEdit)
        router = CreateNoteViewRouter()
        view = CreateNoteVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}
