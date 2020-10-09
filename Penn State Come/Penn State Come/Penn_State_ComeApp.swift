//
//  Penn_State_ComeApp.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

@main
struct Penn_State_ComeApp: App {
    let locationsManager = LocationsManager()
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            CampusView().environmentObject(locationsManager)
        }.onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                locationsManager.campusBuildings.saveData()
            default:
                break
            }
        }
    }
}
