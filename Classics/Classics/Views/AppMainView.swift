//
//  AppMainView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct AppMainView : View{
    var bookLibrary = BookLibrary()
    var body: some View{
        
        NavigationView{
            BookListView()
                .environmentObject(bookLibrary)
                .navigationTitle("Classical Books")
        }
    }
}
