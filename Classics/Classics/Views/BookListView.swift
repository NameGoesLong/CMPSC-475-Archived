//
//  BookListView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookListView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<BookItem>
    private var books: FetchedResults<BookItem> {fetchRequest.wrappedValue}
    
    init(sectionPredicate: NSPredicate?,searchPredicate: NSPredicate?){
        var predicateList : [NSPredicate] = []
        if sectionPredicate != nil {
            predicateList.append(sectionPredicate!)
        }
        if searchPredicate != nil{
            predicateList.append(searchPredicate!)
        }
        switch predicateList.count{
        case 1:
            fetchRequest = FetchRequest<BookItem>(
                entity: BookItem.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                predicate: predicateList[0],
                animation: .default
            )
        case 2:
            fetchRequest = FetchRequest<BookItem>(
                        entity: BookItem.entity(),
                        sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicateList),
                        animation: .default
                    )
        default:
            fetchRequest = FetchRequest<BookItem>(
                        entity: BookItem.entity(),
                        sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                        animation: .default
                    )
        }
    }
    
    var body: some View{
        Group{
            if books.count == 0{
                Text("No book under the selected condition")
            }
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
    }
    
}
