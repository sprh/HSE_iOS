//
//  NotesListRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INotesListRouter {
    var viewController: INotesListVC? { get set }

    func shouldShowDetailScreen(worker: ICoreDataWorker, observer: ICreateNoteViewObserver?)
    func showError(text: String)
}

final class NotesListViewRouter: INotesListRouter {
    weak var viewController: INotesListVC?

    func shouldShowDetailScreen(worker: ICoreDataWorker, observer: ICreateNoteViewObserver?) {
        let viewController = CreateNoteGraph(worker: worker, observer: observer).viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showError(text: String) {
        let alert = UIAlertController(title: "Error(", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}
