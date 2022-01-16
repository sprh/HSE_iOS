//
//  Status+CoreDataProperties.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 22.10.2021.
//
//

import Foundation
import CoreData


extension Status {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Status> {
        return NSFetchRequest<Status>(entityName: "Status")
    }

    @NSManaged public var status: Int32

}

extension Status : Identifiable {

}
