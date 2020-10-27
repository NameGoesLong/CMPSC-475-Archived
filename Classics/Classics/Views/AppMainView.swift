//
//  AppMainView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

enum DisplayMode : String {
    case listMode = "square.grid.2x2"
    case cardMode = "list.dash"
}

// Switch between the displaymode
struct AppMainView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    @State var displaymode : DisplayMode = .listMode
    @State var selectionMode : SelectionMode = .Default
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BookItem.title, ascending: true)],
                      animation: .default)
        private var books: FetchedResults<BookItem>

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: true)],
                      animation: .default)
        private var notes: FetchedResults<NoteItem>
    
    var body: some View{
        NavigationView{
            Group{
                switch displaymode{
                case .listMode:
                    BookListView(predicate: sectionFilter(for: self.selectionMode))
                        .environmentObject(bookLibrary)
                case .cardMode:
                    BookCardView(predicate: sectionFilter(for: self.selectionMode))
                        .environmentObject(bookLibrary)
                }
            }.navigationTitle("Classical Books")
            .navigationBarItems(leading: Preferences(typeIndex: $selectionMode),trailing: preferenceButton)
            
        }.onAppear() {
            addAllBooks()
        }
    }
    
    var preferenceButton: some View {
        Button(action: {
                if self.displaymode == .cardMode{
                    self.displaymode = .listMode
                }
                else{
                    self.displaymode = .cardMode
                }
                     }) {
            Image(systemName: displaymode.rawValue)
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    // Function to pass in the correct NSPredicate
    func sectionFilter(for selectionMode:SelectionMode) ->  (NSPredicate?) {
        switch selectionMode {
        case .CurrentlyReading:
            return NSPredicate(format: "currentlyReading == %@",NSNumber(value: true))
        case .FinishedReading:
            return NSPredicate(format: "%K == %K","pages","progress")
        default:
            return nil
        }
    }

    //MARK: - Core Data
    
    let alreadyLoadedKey = "AlreadyLoaded"
    func addAllBooks() {
        let userDefaults = UserDefaults.standard
        let alreadyLoaded = userDefaults.bool(forKey: alreadyLoadedKey)
        if !alreadyLoaded {
            //Create book managed objects
            bookLibrary.allBooks.forEach {(book) in
                addBook(book: book)
                save()  // need this here so fetch results get updated!
            }
            
            userDefaults.set(true, forKey: alreadyLoadedKey)
            userDefaults.synchronize()
        }
    }
    
    func addBook(book: Book) {
        let newBook = BookItem(context: viewContext)
        newBook.author = book.author
        newBook.country = book.country
        newBook.image = book.image
        newBook.language = book.language
        newBook.link = book.link
        newBook.pages = Int32(book.pages)
        newBook.title = book.title
        newBook.year = Int16(book.year)
        newBook.currentlyReading = book.currentlyReading
        newBook.progress = Int32(book.progress)
    }
    
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
