//
//  TagApp.swift
//  Tag
//
//  Created by New User on 8/11/20.
//

import SwiftUI

@main
struct TagApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) private var scenePhase


    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
