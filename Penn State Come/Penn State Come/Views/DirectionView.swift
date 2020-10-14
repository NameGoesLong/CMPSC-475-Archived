//
//  DirectionView.swift
//  Penn State Come
//
//  Created by New User on 13/10/20.
//

import SwiftUI

struct DirectionView : View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State var Source : String = ""
    @State var Destination : String = ""
    var body: some View{
        NavigationView{
            VStack{
                selectionView
                directionList
            }.navigationTitle("Get Direction")
        }
    }
    
    var selectionView : some View {
        VStack{
            NavigationLink(
                destination: SearchView(tab : $Source).environmentObject(locationsManager)
                ){
                TextField("Please input your start location", text: $Source).textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            NavigationLink(
                destination: SearchView(tab : $Destination).environmentObject(locationsManager)
                ){
                TextField("Please input your destination", text: $Destination).textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            Button(action: {print("Search clicked")}){
                Text("Get Direction")
            }.buttonStyle(SelectionButtonStyle())
        }.padding(.all)
    }
    
    var directionList : some View {
        VStack{
            List{
                ForEach(1..<10){i in
                    Text("Step \(i)")
                }
            }
        }
    }
}
