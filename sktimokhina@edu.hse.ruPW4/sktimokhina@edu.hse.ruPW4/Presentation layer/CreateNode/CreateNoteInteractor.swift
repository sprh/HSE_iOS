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
    func didUpdateItem()
}

protocol ICreateNoteInteractor {
    func saveNote(title: String, description: String, importance: Int32)
    func updateIfNeeded()
}

final class CreateNoteInteractor: ICreateNoteInteractor {
    private let presenter: ICreateNotePresenter
    private let worker: ICoreDataWorker
    private let parentNote: Note?
    private let noteToEdit: Note?
    weak var observer: ICreateNoteViewObserver?

    init(presenter: ICreateNotePresenter,
         worker: ICoreDataWorker,
         observer: ICreateNoteViewObserver?,
         parentNote: Note?,
         noteToEdit: Note?) {
        self.presenter = presenter
        self.observer = observer
        self.worker = worker
        self.parentNote = parentNote
        self.noteToEdit = noteToEdit
    }

    func saveNote(title: String, description: String, importance: Int32) {
        do {
            if (noteToEdit != nil && noteToEdit != nil) {
                try worker.update(note: noteToEdit!, title: title, description: description, status: importance)
                observer?.didUpdateItem()
            } else {
                try worker.save(title: title, description: description, importance: importance, parentNote: parentNote)
                observer?.didAddItem()
            }
            presenter.shouldClose()
        } catch (let e) {
            presenter.shouldShowError(message: e.localizedDescription)
        }
    }

    func updateIfNeeded() {
        guard let noteToEdit = noteToEdit else {
            return
        }
        presenter.update(description: noteToEdit.descriptionText, title: noteToEdit.title, status: Int(noteToEdit.status))
    }
}
