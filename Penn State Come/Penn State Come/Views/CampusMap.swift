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
    @State var userTrackingMode : MapUserTrackingMode = .follow
    @State var campusBuildings = CampusBuildings()
    //@State private var centerCoordinate = CLLocationCoordinate2D()
    
    
    var body: some View {
        Map(coordinateRegion: $locationsManager.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: locationsManager.mappedPlaces,
            annotationContent: annotationsForCategory)
            .overlay(buttonGroupView,alignment: .bottom)
            .animation(.easeInOut(duration: 1.0))
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
    func annotationsForCategory (item:Building) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(systemName: "mappin.and.ellipse").renderingMode(.template)
                .foregroundColor(item.favorite ? Color.red : Color.black)
        }
    }
    func annotationPins (item:Building) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationMarkers (item:Building) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
    
}

struct CampusMap_Previews: PreviewProvider {
    static var previews: some View {
        CampusMap()
    }
}
