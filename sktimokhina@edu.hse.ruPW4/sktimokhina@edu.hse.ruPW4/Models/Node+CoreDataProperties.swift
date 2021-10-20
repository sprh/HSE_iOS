//
//  Node+CoreDataProperties.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//
//

import Foundation
import CoreData


extension Node {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Node> {
        return NSFetchRequest<Node>(entityName: "Node")
    }

    @NSManaged public var descriptionText: String?
    @NSManaged public var status: Int32
    @NSManaged public var title: String

}

extension Node : Identifiable {

}
