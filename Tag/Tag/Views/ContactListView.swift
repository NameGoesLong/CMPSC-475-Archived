//
//  ContactList.swift
//  Tag
//
//  Created by New User on 16/11/20.
//

import SwiftUI
import Contacts

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
