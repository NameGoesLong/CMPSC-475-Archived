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
    var body: some View{
        List{
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                )
            Text(book.title)
            VStack{
                HStack {
                    ProgressView("Reading Progress…", value: Double(book.progress * 100 / book.pages), total: 100)
                    Button(action:{print("clicked")}){
                        Text("Update")
                    }
                }
                
                TextField("Update progress", text: $tempProgress, onCommit: {
                    book.progress = Int(tempProgress)!
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                
            }
            if book.author != nil{
                Text(book.author!)
            }
            Text(book.country)
            Text(book.language)
            Text(book.link)
            Text(String(book.pages))
            buttonGroupView
            NavigationLink(
                destination: NoteListView(book: $book).environmentObject(bookLibrary)){
                Text("Record Notes")
            }
        }
    }
    
    var buttonGroupView : some View{
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    bookLibrary.addToReadingList(book: book)
                }){
                        book.currentlyReading ?
                            Text("Already inside the list")
                            : Text("Add the book to reading list")
                }.buttonStyle(ResultButtonStyle())
                .disabled(book.currentlyReading)
                .opacity(book.currentlyReading ? 0.4 : 0.8)
                Spacer()
            }
//            HStack{
//                Spacer()
//                Button(action: {print("Record progress")}){
//                    Text("Record Progress")
//                }.buttonStyle(ResultButtonStyle())
//                Spacer()
//            }
        }.padding(10.0)
    }
}
