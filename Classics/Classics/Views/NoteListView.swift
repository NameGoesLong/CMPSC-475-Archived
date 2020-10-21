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
            let myEditButton: Button<Text> = Button(editing ? "Done" : "Edit", action: {editing.toggle()})
            
            Group {
                if book.noteList.count == 0 {
                    Text("no note")
                }
                ForEach(0..<book.noteList.count, id:\.self) { index in
                    NoteItemView(note:$book.noteList[index])
                }
            }
            .navigationTitle(Text("Things To Do"))
            .navigationBarItems(leading: addButton,
                                trailing: myEditButton)
            
            .environment(\.editMode, $editMode)
        }
        .sheet(isPresented: $isAdding) {
            TextField("Add", text: $addTextItem, onEditingChanged: {_ in}) {
                bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)].addNote(noteBody: addTextItem)
                addTextItem = ""
                isAdding = false
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            Spacer()
        }
        
    }

    private var addButton : some View {
        Button(action: {isAdding = true})
            { Image(systemName: "plus") }}


}

