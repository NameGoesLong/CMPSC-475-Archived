//
//  SectionView.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

// views for all the states satisfying the filter based on section style and title.  Obtains bindings for states by finding the indices of the states satisfying the property.
struct SectionViews : View {
    @Binding var campusBuildings : CampusBuildings
    var filter : ((Building) -> Bool)
    
    var body : some View {
        
        ForEach(campusBuildings.stateIndices(for: filter), id:\.self) { index in
            BuildingRowView(building: self.campusBuildings.allBuildings[index])
            
        }
    }
}
