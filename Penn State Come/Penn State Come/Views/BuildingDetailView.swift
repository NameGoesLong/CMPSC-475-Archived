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
    @Binding var tabSelection :Int
    
    var body : some View{
        List{
            HStack{
                Spacer()
                Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                        tabSelection = 1
                    locationsManager.campusBuildings.pinnedBuildingsList.append(building)
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
            
            //Image for pokemon. Turned grey when not captured, the background become the color of the first of its types when captured
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
