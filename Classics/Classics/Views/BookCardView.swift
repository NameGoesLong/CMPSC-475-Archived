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
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                      animation: .default)
        private var books: FetchedResults<BookItem>
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(bookLibrary.bookIndices(for: sectionFilter(for: typeIndex)),
                        id:\.self){ index in
                    NavigationLink(
                        destination: BookDetailView(book: $bookLibrary.allBooks[index])
                            .environmentObject(bookLibrary)
                    ){
                        BookCardItem(book: bookLibrary.allBooks[index])
                    }
                }
            }
        }
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
