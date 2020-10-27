//
//  BookCardItem.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI


struct BookCardItem : View {
    @ObservedObject var book :BookItem
    var body: some View{
        VStack{
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 160, alignment: .center)
            Text(book.title)
        }.frame(width: 130, height: 180)
        .padding(10.0)
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .opacity(0.08))
    }
}
