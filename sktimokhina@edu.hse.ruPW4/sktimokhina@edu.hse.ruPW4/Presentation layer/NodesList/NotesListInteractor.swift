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
    var parentNote: Note? { get set }
    var coreDataWorker: ICoreDataWorker { get }
    var parentNoteTitle: String? { get }
    func load()

    func getNote(at index: Int) -> Note?
    func getNote(with id: ObjectIdentifier) -> Note?
    func deleteNote(id: ObjectIdentifier)
}

final class NotesListInteractor: INotesListInteractor {
    let presenter: INotesListPresenter
    private let worker: ICoreDataWorker
    var parentNote: Note?

    private var notes: [Note] = []

    var coreDataWorker: ICoreDataWorker {
        worker
    }

    var notesCount: Int {
        notes.count
    }

    var parentNoteTitle: String? {
        parentNote?.title
    }
    func getNote(at index: Int) -> Note? {
        return index < notes.count ? notes[index] : nil
    }

    func getNote(with id: ObjectIdentifier) -> Note? {
        return notes.first(where: { $0.id == id })
    }

    init(presenter: INotesListPresenter, worker: ICoreDataWorker, parentNote: Note?) {
        self.presenter = presenter
        self.worker = worker
        self.parentNote = parentNote
    }

    func load() {
        do {
            notes = try worker.loadAll(parentNote: parentNote)
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
