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
    @Environment(\.editMode) var mode

    @State var editMode = EditMode.inactive
    @State private var addTextItem : String = ""
    @State private var isAdding = false

    @State private var selectedItems = IndexSet()
    @State private var editing = false

    var body: some View {
        ScrollView{
//            let myEditButton: Button<Text> = Button(editing ? "Done" : "Edit", action: {editing.toggle()})
            
            Group {
                if book.noteList.count == 0 {
                    Text("There is currently no note for this book.")
                }
                ForEach((0..<book.noteList.count).reversed(), id:\.self) { index in
                    NoteItemView(note:book.noteList[index], bookIndex: bookLibrary.getBookPlace(book: book), noteIndex: index).environmentObject(bookLibrary)
                }
//                .onDelete{indexSet in
//                    bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)].deleteNote(indexSet: indexSet)
//                }
            }
            .navigationTitle(Text("BookNotes"))
            .navigationBarItems(leading: addButton,
                                trailing: EditButton())
            
            .environment(\.editMode, $editMode)
        }
        .sheet(isPresented: $isAdding) {
            VStack{
                Text("Add new note").font(.largeTitle).padding()
                TextField("Add", text: $addTextItem, onEditingChanged: {_ in}) {
                    bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)].addNote(noteBody: addTextItem)
                    addTextItem = ""
                    isAdding = false
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            Spacer()
        }
        
    }

    private var addButton : some View {
        Button(action: {isAdding = true})
            { Image(systemName: "plus") }}


}

