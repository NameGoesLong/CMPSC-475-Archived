//
//  LocationsManager.swift
//  Penn State Come
//
//  Created by New User on 7/10/20.
//

import Foundation
import MapKit

class LocationsManager : ObservableObject {
    @Published var campusBuildings = CampusBuildings()
    
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: CampusBuildings.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: CampusBuildings.span, longitudeDelta: CampusBuildings.span))
    
    // Map will annotate these items
    var mappedPlaces = [Building]()
    
    var annotatedPlaces : [Building] {
        mappedPlaces + self.getFavoriteList()
    }
    func recenter(building: Building){
        region.center = building.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
    
    func cleanPinnedBuildings(){
        mappedPlaces = []
    }
    
    func addToMapped(buiding: Building){
        if !mappedPlaces.contains(where:{$0.id==buiding.id}){
            mappedPlaces.append(buiding)
        }
    }
    
    func getFavoriteList() -> [Building] {
        var result = [Building]()
        
        campusBuildings.allBuildings.forEach{building in
            if building.favorite{
                result.append(building)
            }
        }
        return result
    }
}
