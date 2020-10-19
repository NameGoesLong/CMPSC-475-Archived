//
//  BookDetailView.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookDetailView : View {
    @EnvironmentObject var bookLibrary : BookLibrary
    @Binding var book :Book
    var body: some View{
        List{
            buttonGroupView
        }
    }
    
    var buttonGroupView : some View{
        VStack{
            Button(action: {print("Add to readlist")}){
                Text("Add the book to reading list")
            }
            Button(action: {print("Record progress")}){
                Text("Record Progress")
            }
        }.padding(10.0)
    }
}
