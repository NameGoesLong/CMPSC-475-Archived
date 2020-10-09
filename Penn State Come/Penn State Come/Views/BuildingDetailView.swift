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
            HStack{
                Spacer()
                Button(action:{
                    tabSelection = "map"
                    locationsManager.addToMapped(buiding: building)
                    locationsManager.recenter(building: building)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Pin building in map")
                }.padding(.top)
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
            HStack{
                Spacer()
                //action:{campusBuildings.allBuildings[building.id - 1].favorite.toggle()}
                Button(action:{building.favorite.toggle()}){
                    building.favorite ? Text("Cancel the favorite") : Text("Favorite building")
                }.padding(.top)
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
            Text(building.name)
            
            Image(building.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
//                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                )
        }
    }
}
