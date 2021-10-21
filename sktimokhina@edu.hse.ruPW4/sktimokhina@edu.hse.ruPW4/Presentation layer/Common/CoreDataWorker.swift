//
//  CoreDataWorker.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import CoreData

protocol ICoreDataWorker {
    func loadAll() throws -> [Note]
    func save(title: String, description: String, importance: Int32) throws
    func delete(note: Note) throws
}

final class CoreDataWorker: ICoreDataWorker {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadAll() throws -> [Note] {
        var request = NSFetchRequest<NSFetchRequestResult>()
        request = Note.fetchRequest()
        request.returnsObjectsAsFaults = false
        let notes = try context.fetch(request) as! [Note]
        return notes
    }

    func save(title: String, description: String, importance: Int32) throws {
        let note = Note(context: context)
        note.title = title
        note.descriptionText = description
        note.status = importance
        context.insert(note)
        try context.save()
    }

    func delete(note: Note) throws {
        context.delete(note)
        try context.save()
    }
}
