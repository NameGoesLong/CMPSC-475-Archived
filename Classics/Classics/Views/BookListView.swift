//
//  BookListView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookListView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    //@Binding var typeIndex : SelectionMode
    
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<BookItem>
    private var books: FetchedResults<BookItem> {fetchRequest.wrappedValue}
    
    init(predicate: NSPredicate?){
        if predicate != nil{
            fetchRequest = FetchRequest<BookItem>(
                        entity: BookItem.entity(),
                        sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                        predicate: predicate!,
                        animation: .default
                    )
        }else{
            fetchRequest = FetchRequest<BookItem>(
                        entity: BookItem.entity(),
                        sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                        animation: .default
                    )
        }
    }
    
    var body: some View{
        List{
            ForEach(
                books,
                id:\.self){ book in
                NavigationLink(
                    destination: BookDetailView(book: book)
                        .environmentObject(bookLibrary).environment(\.managedObjectContext, viewContext)
                ){
                    BookListRow(book: book)
                }
            }
        }.listStyle(PlainListStyle())
    }
    
    // generate a filter (predicate function) that tests whether a book belongs in the section with title sectionTitle using sectionStyle
//    func sectionFilter(for selectionMode:SelectionMode) ->  ((Book) -> Bool) {
//        switch selectionMode {
//        case .CurrentlyReading:
//            return {$0.currentlyReading}
//        case .FinishedReading:
//            return {$0.progress == $0.pages}
//        default:
//            return {_ in true}
//        }
//    }
//
}
