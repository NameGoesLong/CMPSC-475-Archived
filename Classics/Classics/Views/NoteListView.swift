//
//  NoteView.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import SwiftUI

struct NoteListView: View {
    @EnvironmentObject var bookLibrary : BookLibrary
    @Binding var book : Book
    
    @State private var addTextItem : String = ""
    @State private var isAdding = false

    @State private var selectedItems = IndexSet()
    @State private var editing = false

    var body: some View {
        ScrollView{
            
            Group {
                if book.noteList.count == 0 {
                    Text("There is currently no note for this book.")
                }
                ForEach((0..<book.noteList.count).reversed(), id:\.self) { index in
                    NoteItemView(note:book.noteList[index], bookIndex: bookLibrary.getBookPlace(book: book), noteIndex: index).environmentObject(bookLibrary)
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
                        bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)].addNote(noteBody: addTextItem)
                        addTextItem = ""
                    }
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

