//
//  NotesListRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INotesListRouter {
    var viewController: INotesListVC? { get set }

    func shouldShowDetailScreen(worker: ICoreDataWorker,
                                observer: ICreateNoteViewObserver?,
                                parentNote: Note?)
    func shouldShowDetailScreen(worker: ICoreDataWorker,
                                observer: ICreateNoteViewObserver?,
                                noteToEdit: Note)
    func showError(text: String)
    func openNoteListScreen(worker: ICoreDataWorker, parentNote: Note)
}

final class NotesListRouter: INotesListRouter {
    weak var viewController: INotesListVC?

    func shouldShowDetailScreen(worker: ICoreDataWorker,
                                observer: ICreateNoteViewObserver?,
                                parentNote: Note?) {
        let viewController = CreateNoteGraph(worker: worker,
                                             observer: observer,
                                             parentNote: parentNote,
                                             noteToEdit: nil).viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func shouldShowDetailScreen(worker: ICoreDataWorker,
                                observer: ICreateNoteViewObserver?,
                                noteToEdit: Note) {
        let viewController = CreateNoteGraph(worker: worker,
                                             observer: observer,
                                             parentNote: nil,
                                             noteToEdit: noteToEdit).viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showError(text: String) {
        let alert = UIAlertController(title: "Error(", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }

    func openNoteListScreen(worker: ICoreDataWorker, parentNote: Note) {
        let viewController = NotesListGraph(worker: worker, parentNote: parentNote).viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
