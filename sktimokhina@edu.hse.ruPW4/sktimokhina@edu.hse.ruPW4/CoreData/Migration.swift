//
//  Migration.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 30.10.2021.
//

import CoreData

enum FieldKeys: String {
    case title
    case descriptionText
    case status
}

final class Migration: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        guard sInstance.entity.name == "Note",
              let title = sInstance.primitiveValue(forKey: FieldKeys.title.rawValue) as? String,
              let desctiption = sInstance.primitiveValue(forKey: FieldKeys.descriptionText.rawValue) as? String,
              let status = sInstance.primitiveValue(forKey: FieldKeys.status.rawValue) as? Int32 else {
                  try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
                  return
              }
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: manager.destinationContext)
        let statusEntity = NSEntityDescription.insertNewObject(forEntityName: "Status", into: manager.destinationContext)
        statusEntity.setValue(status, forKey: FieldKeys.status.rawValue)
        newNote.setValue(statusEntity, forKey: FieldKeys.status.rawValue)
        newNote.setValue(title, forKey: FieldKeys.title.rawValue)
        newNote.setValue(desctiption, forKey: FieldKeys.descriptionText.rawValue)
        manager.associate(sourceInstance: sInstance, withDestinationInstance: newNote, for: mapping)
    }

    override func createRelationships(forDestination dInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        try super.createRelationships(forDestination: dInstance, in: mapping, manager: manager)
    }

}
