//
//  Alarm+CoreDataProperties.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//
//

import Foundation
import CoreData


extension Alarm {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var time: Date
    @NSManaged public var on: Bool
    @NSManaged public var descriptionText: String?

}

extension Alarm : Identifiable {

}
