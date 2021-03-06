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
    
    var body: some View {
        Map(coordinateRegion: $locationsManager.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: locationsManager.annotatedPlaces,
            annotationContent: annotationsForCategory)
            .overlay(buttonGroupView,alignment: .bottom)
            .animation(.easeInOut(duration: 1.0))
    }
    
    // two buttons that control: 1. clearing the pinned annotations and 2. display/hide the favorite items
    var buttonGroupView : some View{
        HStack{
            Button(action: {locationsManager.cleanPinnedBuildings()}) {
                Image(systemName: "xmark.circle").resizable()
                    .frame(width: 30.0, height: 30.0)
                    .disabled(locationsManager.mappedPlaces.isEmpty)
            }.padding(.horizontal, 15.0)
            .background(Circle().fill(Color.white))
            
            Button(action: {
                    locationsManager.showFavorite.toggle()
                
            }) {
                Image(systemName: "heart.circle.fill").resizable()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(locationsManager.showFavorite ? Color.red : Color.gray)
            }.padding(.horizontal, 15.0)
            .background(Circle().fill(Color.white))
            
            Button(action: {
                locationsManager.recenterOnUser()
            }) {
                Image(systemName: "location.circle.fill").resizable()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(Color.blue)
            }.padding(.horizontal, 15.0)
            .background(Circle().fill(Color.white))
            
        }.padding(10.0)
    }
    
    //MARK: Three different functions for creating annotations
    // The rest two are implemented for future use
    func annotationsForCategory (item:Building) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(systemName: "mappin.and.ellipse").renderingMode(.template)
                .foregroundColor(locationsManager.showFavorite && item.favorite ? Color.red : Color.black)
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
