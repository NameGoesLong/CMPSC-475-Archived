//
//  BuildingDetailView.swift
//  Penn State Come
//
//  Created by New User on 7/10/20.
//

import SwiftUI

struct BuildingDetailView : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var locationsManager : LocationsManager
    @Binding var building :Building
    @Binding var tabSelection :String
    
    var body : some View{
        List{
            
            //Image for the building with name lying at the bottom
            Image(building.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                ).overlay(
                    Text(building.name)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.all),
                    alignment: .bottom)

            // This is provided for future extension
//            if building.yearConstructed != nil{
//                Text("Constructed in \(building.yearConstructed!)")
//                    .font(.subheadline)
//            }
            
            // Pin button. The action after click:
            //1. pop the navigation view
            //2. switch tabview to map
            //3. center and zoom pinned location
            HStack{
                Spacer()
                Button(action:{
                    tabSelection = "map"
                    locationsManager.addToMapped(buiding: building)
                    locationsManager.recenter(building: building)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Pin building in map")
                }
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
            //Favorite button
            HStack{
                Spacer()
                Button(action:{building.favorite.toggle()}){
                    building.favorite ? Text("Cancel the favorite") : Text("Favorite building")
                }
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
           
        }.navigationBarTitle(building.name,displayMode: .inline)
    }
    
}
