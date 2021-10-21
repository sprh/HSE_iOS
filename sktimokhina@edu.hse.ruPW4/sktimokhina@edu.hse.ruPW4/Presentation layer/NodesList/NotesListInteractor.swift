//
//  NotesListInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol INotesListInteractor {
    var notesCount: Int { get }
    var coreDataWorker: ICoreDataWorker { get }
    func load()

    func getNoteAt(index: Int) -> Note?
    func deleteNote(id: ObjectIdentifier)
}

final class NotesListInteractor: INotesListInteractor {
    let presenter: INotesListPresenter
    private let worker: ICoreDataWorker

    private var notes: [Note] = []

    var coreDataWorker: ICoreDataWorker {
        worker
    }

    var notesCount: Int {
        notes.count
    }

    func getNoteAt(index: Int) -> Note? {
        return index < notes.count ? notes[index] : nil
    }

    init(presenter: INotesListPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func load() {
        do {
            notes = try worker.loadAll()
            presenter.shouldReloadItems()
        } catch (let e) {
            presenter.shouldShowError(text: e.localizedDescription)
        }
    }

    func deleteNote(id: ObjectIdentifier) {
        guard let note = notes.first(where: { $0.id == id }) else { return }
        do {
            try worker.delete(note: note)
            notes.removeAll(where: { $0.id == id })
            presenter.shouldReloadItems()
        } catch (let e) {
            presenter.shouldShowError(text: e.localizedDescription)
        }
    }
}
