//
//  BookDetailView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookDetailView : View {
    @EnvironmentObject var bookLibrary : BookLibrary
    @Binding var book :Book
    @State private var tempProgress = ""
    @State private var updateProgress = false
    var body: some View{
        List{
            HStack{
                Image(book.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5.0)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray)
                            .opacity(0.1)
                    )
                    .frame( maxHeight: 160)
                // Book basic information
                VStack(alignment:.leading){
                    Text("Title:\n \(book.title)")
                        .padding(1)
                    if book.author != nil{
                        Text("Author:\n \(book.author!)")
                            .padding(1)
                    }
                    Text("Country:\n \(book.country)")
                        .padding(1)
                    Text("Language:\n \(book.language)")
                        .padding(1)
                    Spacer()
                }.font(.subheadline)
            }
            // ReadingList Add/Remove
            buttonGroupView
            
            NavigationLink(
                destination: NoteListView(book: $book).environmentObject(bookLibrary)){
                Text("Record Notes")
            }
            
            VStack{
                // Showing reading progress
                ProgressView("Reading Progress: page \(book.progress) / \(book.pages)", value: Double(book.progress * 100 / book.pages), total: 100)
                // Textfield for updating the progress
                // Only accessable when the book is in the reading list
                HStack {
                    TextField("Update progress", text: $tempProgress, onCommit: {
                        if tempProgress.isNumber{
                            if checkValid(progress: Int(tempProgress)!){
                                book.progress = Int(tempProgress)!
                            }
                        }
                        tempProgress = ""
                        updateProgress = false
                    })
                    .disabled(!updateProgress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    
                    
                    Group{
                        Button(action:{
                            if updateProgress{
                                if tempProgress.isNumber{
                                    if checkValid(progress: Int(tempProgress)!){
                                        book.progress = Int(tempProgress)!
                                    }
                                }
                                tempProgress = ""
                            }
                            updateProgress.toggle()
                        }){
                            updateProgress ? Text("Save")
                                : Text("Update")
                        }
                        .disabled(!book.currentlyReading)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                
            }
            Text(book.link)
        }.navigationBarTitle(book.title,displayMode: .inline)
    }
    
    var buttonGroupView : some View{
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    book.currentlyReading ? bookLibrary.removeFromReadingList(book: book) : bookLibrary.addToReadingList(book: book)
                }){
                    book.currentlyReading ?
                        Text("Remove from reading list")
                        : Text("Add to reading list")
                }.buttonStyle(ResultButtonStyle())
                .opacity(book.currentlyReading ? 0.7 : 0.4)
                Spacer()
            }
        }.padding(10.0)
    }
    
    // Helper function for checking whether the progress is valid
    func checkValid(progress input: Int) -> Bool{
        let start = 0
        let end = book.pages
        let validRange = start...end
        return validRange.contains(input)
    }
}
