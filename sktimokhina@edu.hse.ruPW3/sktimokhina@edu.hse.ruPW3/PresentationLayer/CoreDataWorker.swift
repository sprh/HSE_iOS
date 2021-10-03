//
//  CoreDataWorker.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import CoreData

protocol ICoreDataWorker {
}

final class CoreDataWorker: ICoreDataWorker {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
