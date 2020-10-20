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
                bookLibrary.bookIndices(for: sectionFilter(for: typeIndex)),
                id:\.self){ index in
                NavigationLink(
                    destination: BookDetailView(book: $bookLibrary.allBooks[index])
                        .environmentObject(bookLibrary)
                ){
                    BookListRow(book: bookLibrary.allBooks[index])
                }
            }
        }.listStyle(PlainListStyle())
    }
    
    // generate a filter (predicate function) that tests whether a book belongs in the section with title sectionTitle using sectionStyle
    func sectionFilter(for selectionMode:SelectionMode) ->  ((Book) -> Bool) {
        switch selectionMode {
        case .CurrentlyReading:
            return {$0.currentlyReading}
        case .FinishedReading:
            return {$0.progress == $0.pages}
        default:
            return {_ in true}
        }
    }
    
}
