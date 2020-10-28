//
//  ClassicsApp.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import SwiftUI

@main
struct ClassicsApp: App {
    let bookLibrary = BookLibrary()
    let persistenceController = PersistenceController.shared

    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            AppMainView()
                .environmentObject(bookLibrary)
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

