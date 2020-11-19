//
//  NoteView.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import SwiftUI
import CoreData

struct NoteListView: View {
    @EnvironmentObject var bookLibrary : BookLibrary
    @Environment(\.managedObjectContext) private var viewContext
    //@Binding var book : Book
    
    @ObservedObject var book :BookItem
    var fetchRequest: FetchRequest<NoteItem>
    private var notes: FetchedResults<NoteItem> {fetchRequest.wrappedValue}
    
    @State private var addTextItem : String = ""
    @State private var isAdding = false

    @State private var selectedItems = IndexSet()
    @State private var editing = false

    init(book: BookItem){
        self.book = book
        fetchRequest = FetchRequest<NoteItem>(
                    entity: NoteItem.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: false)],
                    predicate: NSPredicate(format: "book == %@",book),
                    animation: .default
                )
    }
    
    var body: some View {
        ScrollView{
            
            Group {
                if notes.count == 0 {
                    Text("There is currently no note for this book.")
                }
                ForEach(notes, id:\.self) { note in
                    NoteItemView(note:note)
                        .environmentObject(bookLibrary)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            .navigationTitle(Text("BookNotes"))
            .navigationBarItems(trailing: addButton)
            
        }
        .sheet(isPresented: $isAdding) {
            VStack{
                Text("Add new note").font(.largeTitle).padding()
                TextField("Add", text: $addTextItem, onEditingChanged: {_ in}) {
                    if addTextItem != ""{
                        let newNote = NoteItem(context: viewContext)
                        newNote.modified = false
                        newNote.noteBody = addTextItem
                        newNote.progress = book.progress
                        newNote.timestamp = Date()
                        newNote.book = book
                        addTextItem = ""
                    }
                    //print("note added")
                    isAdding = false
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Button(action:{
                    addTextItem = ""
                    isAdding = false
                }){
                    Text("Cancel")
                }
            }
            Spacer()
        }
        
    }

    private var addButton : some View {
        Button(action: {
                isAdding = true
            
        }){
            Image(systemName: "plus")
        }.disabled(editing)
        
    }


}

