//
//  CampusMap.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI
import MapKit


struct CampusMap: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State var userTrackingMode  : MapUserTrackingMode = .follow
    
    
    var body: some View {
        Map(coordinateRegion: $locationsManager.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: locationsManager.mappedPlaces,
            annotationContent: annotationsForCategory)
            .overlay(buttonGroupView,alignment: .bottom)
    }
    
    var buttonGroupView : some View{
        HStack{
            Button(action: {print("button clicked")}) {
                Image(systemName: "xmark.circle")
            }.padding(.all)
            Button(action: {print("heart clicked")}) {
                Image(systemName: "heart.circle.fill")
            }.padding(.all)
        }
    }
    
    //MARK: Three different functions for creating annotations
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(item.category).renderingMode(.template)
                .foregroundColor(item.highlighted ? Color.red : Color.black)
        }
    }
    func annotationPins (item:Place) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationMarkers (item:Place) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
    
}

struct CampusMap_Previews: PreviewProvider {
    static var previews: some View {
        CampusMap()
    }
}
