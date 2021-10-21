//
//  CreateNoteInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol ICreateNoteViewObserver: AnyObject {
    func didAddItem()
}

protocol ICreateNoteInteractor {
    func saveNote(title: String, description: String, importance: Int32)
}

final class CreateNoteInteractor: ICreateNoteInteractor {
    private let presenter: ICreateNotePresenter
    private let worker: ICoreDataWorker
    private let parentNote: Note?
    weak var observer: ICreateNoteViewObserver?

    init(presenter: ICreateNotePresenter,
         worker: ICoreDataWorker,
         observer: ICreateNoteViewObserver?,
         parentNote: Note?) {
        self.presenter = presenter
        self.observer = observer
        self.worker = worker
        self.parentNote = parentNote
    }

    func saveNote(title: String, description: String, importance: Int32) {
        do {
            try worker.save(title: title, description: description, importance: importance, parentNote: parentNote)
            observer?.didAddItem()
            presenter.shouldClose()
        } catch (let e) {
            presenter.shouldShowError(message: e.localizedDescription)
        }
    }
}
