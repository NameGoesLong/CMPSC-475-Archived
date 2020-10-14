//
//  DirectionView.swift
//  Penn State Come
//
//  Created by New User on 13/10/20.
//

import SwiftUI

struct DirectionView : View {
    @State var Start : String = ""
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
                destination: Text("Start")
                ){
                TextField("Please input your start location", text: $Start).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            NavigationLink(
                destination: Text("Destination")
                ){
                TextField("Please input your destination", text: $Destination).textFieldStyle(RoundedBorderTextFieldStyle())
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
