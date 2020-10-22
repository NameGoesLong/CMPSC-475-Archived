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
        return DisclosureGroup("Time: \(note.time)   Progress: \(note.progress)", isExpanded:$revealDetails){
            TextEditor(text: $text)
                .onAppear{
                    self.text = note.noteBody
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(
                    RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray).opacity(isEditing ? 0.1 : 0.5))
                .padding()
                .disabled(!isEditing)
            
            noteButtonGroup
        }
    }
    
    var noteButtonGroup : some View {
        HStack{
            Button(action: {
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
//            Button(action: {
//                self.isEditing = false
//            }){
//                Text("Delete")
//            }.background(Color.primary.opacity(0.2))
//            .padding()
        }
    }
}


struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
