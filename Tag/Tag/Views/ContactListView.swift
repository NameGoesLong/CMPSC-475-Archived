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
    
    init(){
        fetchRequest = FetchRequest<Record>(
            entity: Record.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Record.lastname, ascending: true)],
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
                    destination: Text(record.phone)
                ){
                    ContactListRow(record: record)
                }
                }
        }.listStyle(PlainListStyle())
    }
}
