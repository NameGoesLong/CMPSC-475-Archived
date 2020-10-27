//
//  BookItem+CoreDataProperties.swift
//  Classics
//
//  Created by New User on 26/10/20.
//
//

import Foundation
import CoreData


extension BookItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookItem> {
        return NSFetchRequest<BookItem>(entityName: "BookItem")
    }

    @NSManaged public var author: String?
    @NSManaged public var country: String
    @NSManaged public var image: String
    @NSManaged public var language: String
    @NSManaged public var link: String
    @NSManaged public var pages: Int32
    @NSManaged public var title: String
    @NSManaged public var year: Int16
    @NSManaged public var currentlyReading: Bool
    @NSManaged public var progress: Int32
    @NSManaged public var roster: Set<NoteItem>

}

// MARK: Generated accessors for roster
extension BookItem {

    @objc(addRosterObject:)
    @NSManaged public func addToRoster(_ value: NoteItem)

    @objc(removeRosterObject:)
    @NSManaged public func removeFromRoster(_ value: NoteItem)

    @objc(addRoster:)
    @NSManaged public func addToRoster(_ values: NSSet)

    @objc(removeRoster:)
    @NSManaged public func removeFromRoster(_ values: NSSet)

}

extension BookItem : Identifiable {

}
