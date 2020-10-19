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
            ForEach(bookLibrary.allBooks, id:\.id){ book in
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/
                ){
                    BookListRow(book: book)
                    
                }
            }
        }
    }
}
