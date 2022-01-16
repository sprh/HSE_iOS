//
//  Note+CoreDataProperties.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 22.10.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var descriptionText: String
    @NSManaged public var title: String
    @NSManaged public var parentNote: Note?
    @NSManaged public var status: Status

}

extension Note : Identifiable {

}
