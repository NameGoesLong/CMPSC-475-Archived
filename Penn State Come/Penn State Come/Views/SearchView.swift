//
//  SearchView.swift
//  Penn State Come
//
//  Created by New User on 13/10/20.
//

import SwiftUI
import MapKit

struct SearchView :View{
    @EnvironmentObject var locationsManager : LocationsManager
    @Environment(\.presentationMode) var presentationMode
    @Binding var tab : String
    @Binding var tabGeo : CLLocationCoordinate2D?
    @State private var searchText = ""
    var currentText = "Current Position"
    var body: some View{
        VStack{
            SearchBar(text: $searchText)
                .padding(.all)
            List{
                Button(action: {
                    searchText = currentText
                    tab = currentText
                    tabGeo = nil
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text(currentText)
                }
                ForEach(
                    locationsManager.campusBuildings.allBuildings.filter(
                        { searchText.isEmpty ?
                            true : $0.name.lowercased().contains(searchText.lowercased())
                        }
                    )
                ) { item in
                    Button(action: {
                        searchText = item.name
                        tab = item.name
                        tabGeo = item.coordinate
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text(item.name)
                    }
                }
            }
        }.navigationBarTitle("",displayMode: .inline)
    }
}

// Extracted from https://www.appcoda.com/swiftui-search-bar/
struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
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

        }
    }
}
