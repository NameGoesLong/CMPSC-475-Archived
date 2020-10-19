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
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            AppMainView().environmentObject(bookLibrary)
        }.onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                bookLibrary.saveData()
            default:
                break
            }
        }
    }
}

