//
//  CampusView.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

struct CampusView: View {
    @ObservedObject var locationsManager = LocationsManager()
    @State var tabSelection = 1
    // It requires extra efforts to conform the actions for tabview transition when clicking buttons inside the subview of tab view.
    // This is not addressed perfectly in this app due to limited time given
    var body: some View {
        VStack {
            TabView(selection: $tabSelection){
                CampusMap()
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(locationsManager).tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }.tag(1)
                
                BuildingListView(tabSelection: $tabSelection)
                    .tabItem {
                    Image(systemName: "list.dash")
                    Text("Buildings")
                    }.tag(2)
                    .environmentObject(locationsManager)
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
