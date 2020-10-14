//
//  LocationsManager.swift
//  Penn State Come
//
//  Created by New User on 7/10/20.
//

import Foundation
import MapKit

class LocationsManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager : CLLocationManager
    
    var showsUserLocation = false
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @Published var campusBuildings = CampusBuildings()
    
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: CampusBuildings.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: CampusBuildings.span, longitudeDelta: CampusBuildings.span))
    
    @Published var showFavorite : Bool = false
    
    // Map will annotate these items
    @Published var mappedPlaces = [Building]()
    
    @Published var route : MKRoute?
    
    //MARK: - CLLocationManager Delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
        }
    }
    
    var annotatedPlaces : [Building] {
        if showFavorite{
            // Make sure there is no duplicates in the list, otherwise it would cause error in the map's annotations
            var totalAnnotated = self.getFavoriteList()
            mappedPlaces.forEach{building in
                if !totalAnnotated.contains(where: {$0.id == building.id}){
                    totalAnnotated.append(building)
                }
            }
            return totalAnnotated
        }else{
            return mappedPlaces
        }
    }
    
    func recenter(building: Building){
        region.center = building.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
    
    func recenterOnUser(){
        guard let location = locationManager.location else{
            return
        }
        region.center = location.coordinate
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
    
    //MARK: - Directions
    
    func provideDirections(from source:CLLocationCoordinate2D,to destination:CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))    //notice this is an elementary sloution
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard (error == nil) else {print(error!.localizedDescription); return}
            
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
}
