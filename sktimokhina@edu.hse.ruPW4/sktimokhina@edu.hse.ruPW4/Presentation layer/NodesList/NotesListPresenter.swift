//
//  NotesListPresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol INotesListPresenter {
    var viewController: INotesListVC? { get set }

    func shouldReloadItems()
    func shouldShowError(text: String)
}

final class NotesListPresenter: INotesListPresenter {
    weak var viewController: INotesListVC?

    func shouldReloadItems() {
        viewController?.shouldReloadItems()
    }

    func shouldShowError(text: String) {
        viewController?.shouldShowError(text: text)
    }
}
