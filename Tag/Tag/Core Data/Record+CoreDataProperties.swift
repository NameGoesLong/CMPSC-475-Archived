//
//  Record+CoreDataProperties.swift
//  Tag
//
//  Created by New User on 21/11/20.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var cardImage: Data
    @NSManaged public var firstname: String
    @NSManaged public var lastname: String
    @NSManaged public var phone: String
    @NSManaged public var company: String
    @NSManaged public var position: String
    @NSManaged public var email: String
    

}

extension Record : Identifiable {

}
