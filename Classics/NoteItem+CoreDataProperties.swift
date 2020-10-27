//
//  NoteItem+CoreDataProperties.swift
//  Classics
//
//  Created by New User on 26/10/20.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var progress: Int32
    @NSManaged public var noteBody: String?
    @NSManaged public var modified: Bool
    @NSManaged public var book: BookItem?

}

extension NoteItem : Identifiable {

}
