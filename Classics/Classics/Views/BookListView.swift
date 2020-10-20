//
//  BookListView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookListView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    @Binding var typeIndex : SelectionMode
    var body: some View{
        List{
            ForEach(
//                //When typeIndex is nil, then return all the pokemons
//                //otherwise, return the type the user selected
//                ForEach(
//                    pokedex.pokemonIDs(
//                        for: {typeIndex==nil ? true : $0.types.contains(typeIndex!)}
//                    ),
                bookLibrary.allBooks){ book in
                NavigationLink(
                    destination: BookDetailView(book: $bookLibrary.allBooks[bookLibrary.getBookPlace(book: book)]).environmentObject(bookLibrary)
                ){
                    BookListRow(book: book)
                }
            }
        }.listStyle(PlainListStyle())
    }
    
}
