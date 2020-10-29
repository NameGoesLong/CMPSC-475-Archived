//
//  SearchView.swift
//  Penn State Come
//
//  Created by New User on 13/10/20.
//

import SwiftUI
import MapKit


// Extracted from https://www.appcoda.com/swiftui-search-bar/
struct SearchBar: View {
    @Binding var text: String
    @Binding var filteringRequirement : String
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Picker("selection", selection: $filteringRequirement/*@START_MENU_TOKEN@*//*@END_MENU_TOKEN@*/){
                Text("Author").tag("author")
                Text("Title").tag("title")
            }.padding(.horizontal).pickerStyle(SegmentedPickerStyle())
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                self.isEditing = false
                                self.hideKeyboard()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .autocapitalization(.none)

        }
    }
}
