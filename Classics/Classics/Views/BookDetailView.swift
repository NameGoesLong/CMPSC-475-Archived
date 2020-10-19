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
            if book.author != nil{
                Text(book.author!)
            }
            Text(book.country)
            Text(book.language)
            Text(book.link)
            Text(String(book.pages))
            buttonGroupView
        }
    }
    
    var buttonGroupView : some View{
        VStack{
            Button(action: {
                bookLibrary.addToReadingList(book: book)
            }){
                Text("Add the book to reading list")
            }.buttonStyle(ResultButtonStyle())
            .disabled(book.currentlyReading)
            .opacity(book.currentlyReading ? 0.4 : 0.8)
            Button(action: {print("Record progress")}){
                Text("Record Progress")
            }.buttonStyle(ResultButtonStyle())
        }.padding(10.0)
    }
}
