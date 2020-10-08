//
//  BuildingDetailView.swift
//  Penn State Come
//
//  Created by New User on 7/10/20.
//

import SwiftUI

struct BuildingDetailView : View {
    @Binding var building :Building
    
    var body : some View{
        List{
            HStack{
                Spacer()
                Button(action:{print("Pinned")}){
                    Text("Pin building in map")
                }.padding(.top)
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
            HStack{
                Spacer()
                Button(action:{campusBuildings.allBuildings[building.id - 1].captured.toggle()}){
                    building.favorite ? Text("Cancel the favorite") : Text("Favorite building")
                }.padding(.top)
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
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
