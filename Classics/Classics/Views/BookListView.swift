//
//  BookListView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookListView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    var body: some View{
        List{
            ForEach(bookLibrary.allBooks){ book in
                NavigationLink(
                    destination: BookDetailView(book: $bookLibrary.allBooks[getBookPlace(book: book)]).environmentObject(bookLibrary)
                ){
                    BookListRow(book: book)
                }
            }
        }
    }
    
    func getBookPlace(book: Book) -> Int{
        return bookLibrary.allBooks.firstIndex(where: {$0.id == book.id})!
    }
}
