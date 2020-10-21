//
//  NoteItemView.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import SwiftUI

struct NoteItemView : View {
    @Binding var note: Note
    @State var isEditing = false
    //@Environment(\.editMode) var editMode
    
    
    
    var body : some View {
        UITextView.appearance().backgroundColor = .clear
        return DisclosureGroup("Time: \(note.time)   Progress: \(note.progress)"){
            TextEditor(text: $note.noteBody)
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
                self.isEditing = true
            }){
                Text("Modify")
            }.background(Color.secondary.opacity(0.2))
            .padding()
            
            Button(action: {
                self.isEditing = false
            }){
                Text("Delete")
            }.background(Color.primary.opacity(0.2))
            .padding()
        }
    }
}


struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
