//
//  BookListRow.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

struct BookListRow : View {
    let book : Book
    var body: some View{
        HStack{
            Text(book.title)
            Image(systemName: "tag.circle.fill")
                .foregroundColor(Color.secondary)
                .padding(.all,5.0)
                .opacity(book.currentlyReading ? 0.8 : 0.0)
            Spacer()
                Image(book.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40, alignment: .center)
        }
    }
    
}

struct BookListRow_Previews: PreviewProvider {
    private let bookLibrary = BookLibrary()
    static var previews: some View {
        BookListRow(book: BookLibrary().allBooks[0])
    }
}
