//
//  NoteItemView.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import SwiftUI

struct NoteItemView : View {
    @EnvironmentObject var bookLibrary : BookLibrary

    var note: Note
    var bookIndex : Int
    var noteIndex : Int
    @State var isEditing = false
    @State var text :String = ""
    @State var revealDetails = false
    
    init(note: Note, bookIndex: Int, noteIndex: Int) {
        self.note = note
        self.bookIndex = bookIndex
        self.noteIndex = noteIndex
    }
    
    var body : some View {
        UITextView.appearance().backgroundColor = .clear
        return DisclosureGroup("Time: \(note.timeToString())   Progress: \(note.progress)", isExpanded:$revealDetails){
            ZStack {
                TextEditor(text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray).opacity(isEditing ? 0.1 : 0.5))
                    .padding()
                    .disabled(!isEditing)
                Text(text).opacity(0).padding(.all, 8) // <- This will solve the issue if it is in the same ZStack
            }
            
            noteButtonGroup
        }.onAppear(){
            self.text = note.noteBody
        }
    }
    
    var noteButtonGroup : some View {
        HStack{
            Button(action: {
                if self.isEditing{
                    bookLibrary.allBooks[bookIndex].noteList[noteIndex].noteBody = text
                }
                self.isEditing.toggle()
            }){
                if self.isEditing{
                    Text("Save")
                }else{
                    Text("Modify")

                }
            }.background(Color.secondary.opacity(0.2))
            .padding()
            Button(action: {
                self.isEditing = false
                revealDetails = false
                bookLibrary.allBooks[bookIndex].noteList.remove(at: noteIndex)
            }){
                Text("Delete")
            }.background(Color.secondary.opacity(0.2))
            .padding()
        }
    }
}


struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
