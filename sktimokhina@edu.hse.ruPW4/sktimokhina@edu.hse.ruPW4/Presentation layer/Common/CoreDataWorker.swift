//
//  CoreDataWorker.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import CoreData

protocol ICoreDataWorker {
    func loadAll(parentNote: Note?) throws -> [Note]
    func save(title: String, description: String, status: Int32, parentNote: Note?) throws
    func delete(note: Note) throws
    func update(note: Note,
                title: String,
                description: String,
                status: Int32) throws
}

final class CoreDataWorker: ICoreDataWorker {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadAll(parentNote: Note?) throws -> [Note] {
        var request = NSFetchRequest<NSFetchRequestResult>()
        request = Note.fetchRequest()
        if (parentNote == nil) {
            request.predicate = NSPredicate(format: "parentNote == nil");
        } else {
            let predicate1 = NSPredicate(format: "parentNote != nil")
            let predicate2 = NSPredicate(format: "parentNote == %@", parentNote!)
            request.predicate = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        }
        request.returnsObjectsAsFaults = false
        let notes = try context.fetch(request) as! [Note]
        return notes
    }

    func save(title: String, description: String, status: Int32, parentNote: Note?) throws {
        let note = Note(context: context)
        let noteStatus = Status(context: context)
        noteStatus.status = status
        note.parentNote = parentNote
        note.title = title
        note.descriptionText = description
        note.status = noteStatus
        context.insert(note)
        try context.save()
    }

    func delete(note: Note) throws {
        context.delete(note)
        try context.save()
    }

    func update(note: Note,
                title: String,
                description: String,
                status: Int32) throws {
        let noteStatus = Status(context: context)
        noteStatus.status = status
        note.title = title
        note.descriptionText = description
        note.status = noteStatus
        try context.save()
    }
}
