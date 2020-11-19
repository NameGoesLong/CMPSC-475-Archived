//
//  Record+CoreDataProperties.swift
//  Tag
//
//  Created by New User on 18/11/20.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var firstname: String
    @NSManaged public var lastname: String
    @NSManaged public var phone: String

}

extension Record : Identifiable {

}
