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
    
    @State var sectionStyle = SectionStyle.byFirstName
    
    
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
        VStack{
            if records.count == 0{
                Text("No record under the selected condition")
            }
            List{
                ForEach(
                    update(records),
                    id:\.self){ (section: [Record]) in
                    Section(header:
                                    Text(section[0].lastname.firstLetter!)
                    ){
                        ForEach(section, id:\.self){record in
                            NavigationLink(
                                destination: ContactDetailView(record: record)
                            ){
                                ContactListRow(record: record)
                            }
                        }.onDelete{
                            self.deleteItem(at: $0, in: section)
                            
                        }
                    }
                }
            }.listStyle(PlainListStyle())
        }
        
    }
    
    func deleteItem(at offsets: IndexSet, in section:[Record]) {
        
        for offset in offsets {
            let record =  section[offset]
            self.viewContext.delete(record)
        }
    }
    
    func update(_ result : FetchedResults<Record>)-> [[Record]]{
        return  Dictionary(grouping: result){ (element : Record)  in
            element.lastname.firstLetter!
        }.values.sorted(){
            $0[0].lastname.firstLetter! < $1[0].lastname.firstLetter!
        }
    }
}
