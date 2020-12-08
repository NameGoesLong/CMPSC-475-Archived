//
//  ContactList.swift
//  Tag
//
//  Created by New User on 16/11/20.
//

import SwiftUI
import Contacts

enum SectionStyle: String, CaseIterable {
    case none, byFirstName, byLastName
}

struct ContactListView : View {
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Record>
    private var records: FetchedResults<Record> {fetchRequest.wrappedValue}
    
    init(searchPredicate: NSCompoundPredicate?){
        //notice the oredicate could be nil
        fetchRequest = FetchRequest<Record>(
            entity: Record.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Record.lastname, ascending: true)],
            predicate: searchPredicate,
            animation: .default
        )
    }
    
    var body: some View{
        if records.count == 0{
            Text("No record under the selected condition")
        }
        List{
            ForEach(
                records,
                id:\.self){ record in
                NavigationLink(
                    destination: ContactDetailView(record: record)
                ){
                    ContactListRow(record: record)
                }
                }
            .onDelete(perform: delete)
        }.listStyle(PlainListStyle())
        
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let record = records[index]
            self.viewContext.delete(record)
        }
    }
    
    // generate array of section titles based on section style
//    func sectionTitles(for sectionStyle:SectionStyle) -> [String] {
//        switch sectionStyle {
//        case .byFirstName:
//            return locationsManager.campusBuildings.buildingTitles(using: {$0.name.firstLetter!})
//        case .byLastName:
//            return {$0.lastname.firstLetter! == sectionTitle}
//        default:
//            assert(false, "No section titles for .none option")
//        }
//    }
    
    // generate a filter (predicate function) that tests whether a state belongs in the section with title sectionTitle using sectionStyle (by Name or by Decade)
    
    func sectionFilter(for sectionStyle:SectionStyle, sectionTitle:String) ->  ((Record) -> Bool) {
        switch sectionStyle {
        case .byFirstName:
            return {$0.firstname.firstLetter! == sectionTitle}
        case .byLastName:
            return {$0.lastname.firstLetter! == sectionTitle}
        default:
            assert(false, "No section filtering for .none option")
        }
    }
    
    //    let words = searchText.components(separatedBy: " ")
    //
    //            var predicateArr = [NSPredicate]()
    //            for word in words! {
    //                let predicate = NSPredicate(format: "(hotelName contains [c]) OR (cityName contains [c])", word, word)
    //                predicateArr.append(predicate)
    //            }
    //
    //
    //            let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
    //            let output = array.filtered(using: compound)
}
