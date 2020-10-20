//
//  BookCardView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookCardView : View  {
    @EnvironmentObject var bookLibrary :BookLibrary
    @Binding var typeIndex : SelectionMode
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(bookLibrary.allBooks){ book in
                    NavigationLink(
                        destination: BookDetailView(book: $bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)]).environmentObject(bookLibrary)
                    ){
                        BookCardItem(book: book)
                    }
                }
            }
        }
    }
}
