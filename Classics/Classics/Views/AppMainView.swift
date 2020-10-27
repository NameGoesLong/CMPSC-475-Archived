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
                    BookListView(typeIndex: $selectionMode)
                        .environmentObject(bookLibrary)
                case .cardMode:
                    BookCardView(typeIndex: $selectionMode)
                        .environmentObject(bookLibrary)
                }
            }.navigationTitle("Classical Books")
            .navigationBarItems(leading: Preferences(typeIndex: $selectionMode),trailing: preferenceButton)
            
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

}
