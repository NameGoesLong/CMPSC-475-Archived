//
//  DirectionView.swift
//  Penn State Come
//
//  Created by New User on 13/10/20.
//

import SwiftUI
import MapKit

struct DirectionView : View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State var Source : String = ""
    @State var SourceGeo : CLLocationCoordinate2D? = nil
    @State var DestinationGeo : CLLocationCoordinate2D? = nil
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
                destination: SearchView(tab : $Source, tabGeo: $SourceGeo).environmentObject(locationsManager)
                ){
                TextField("Please input your start location", text: $Source).textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            NavigationLink(
                destination: SearchView(tab : $Destination, tabGeo: $DestinationGeo).environmentObject(locationsManager)
                ){
                TextField("Please input your destination", text: $Destination).textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Button(action: {
                    Source = ""
                    Destination = ""
                    locationsManager.route = nil
                }){
                    Text("Clear Search")
                }.buttonStyle(SelectionButtonStyle())
                Button(action: {
                    print("Search clicked")
                    locationsManager.provideDirections(from: SourceGeo, to: DestinationGeo)
                    
                }){
                    Text("Get Direction")
                }.buttonStyle(SelectionButtonStyle())
            }
        }.padding(.all)
    }
    
    var directionList : some View {
        VStack{
            if locationsManager.route != nil{
                VStack{
                    Text("ETA: \(locationsManager.route!.expectedTravelTime.stringFromTimeInterval())")
                    List {
                        ForEach(locationsManager.route?.steps ?? [], id:\.instructions) {step in
                            Text(step.instructions)
                        }
                    }.listStyle(PlainListStyle())
                }
            }else{
                Spacer()
            }
        }
    }
}
