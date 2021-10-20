//
//  CoreDataWorker.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import CoreData

protocol ICoreDataWorker {
    func loadAll() throws -> [Node]
    func save(title: String, description: String, importance: Int32) throws
}

final class CoreDataWorker: ICoreDataWorker {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadAll() throws -> [Node] {
        var request = NSFetchRequest<NSFetchRequestResult>()
        request = Node.fetchRequest()
        request.returnsObjectsAsFaults = false
        let nodes = try context.fetch(request) as! [Node]
        return nodes
    }

    func save(title: String, description: String, importance: Int32) throws {
        let node = Node(context: context)
        node.title = title
        node.descriptionText = description
        node.status = importance
        context.insert(node)
        try context.save()
    }
}
