//
//  CampusView.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

struct CampusView: View {
    @ObservedObject var locationsManager = LocationsManager()
    
    var body: some View {
        VStack {
            TabView{
                CampusMap()
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(locationsManager).tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                
                BuildingListView().tabItem {
                    Image(systemName: "list.dash")
                    Text("Buildings")
                }
            }
        }
    }
    
    var placesHeight : CGFloat = 60.0
}


struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        CampusView()
    }
}
