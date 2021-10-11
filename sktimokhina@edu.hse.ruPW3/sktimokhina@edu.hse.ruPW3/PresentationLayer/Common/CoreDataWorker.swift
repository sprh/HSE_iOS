//
//  CoreDataWorker.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import CoreData

protocol ICoreDataWorker {
    func didTapSaveButton(time: Date, descriptionText: String, isOn: Bool) throws
    func loadAll() throws -> [Alarm]
    func update(alarm: Alarm, isOn: Bool) throws
}

final class CoreDataWorker: ICoreDataWorker {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func didTapSaveButton(time: Date, descriptionText: String, isOn: Bool) throws {
        let alarm = Alarm(context: context)
        alarm.descriptionText = descriptionText
        alarm.time = time
        alarm.on = isOn
        context.insert(alarm)
        try context.save()
    }

    func update(alarm: Alarm, isOn: Bool) throws {
        alarm.on = isOn
        try context.save()
    }

    func loadAll() throws -> [Alarm] {
        let alarms = try context.fetch(Alarm.fetchRequest()) as [Alarm]
        return alarms
    }
}
