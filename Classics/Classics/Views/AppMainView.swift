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

struct AppMainView : View{
    @EnvironmentObject var bookLibrary : BookLibrary
    @State var displaymode : DisplayMode = .listMode
    var body: some View{
        NavigationView{
            Group{
                switch displaymode{
                case .listMode:
                    BookListView()
                        .environmentObject(bookLibrary)
                case .cardMode:
                    BookCardView()
                        .environmentObject(bookLibrary)
                }
            }.navigationTitle("Classical Books")
            .navigationBarItems(leading: Preferences(),trailing: preferenceButton)
            
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
