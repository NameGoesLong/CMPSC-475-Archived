//
//  MainView.swift
//  Tag
//
//  Created by New User on 8/11/20.
//

import Foundation
import SwiftUI

struct MainView : View{
    @Environment(\.managedObjectContext) private var viewContext    
    @State var isActive = false
    
    var body: some View {
        VStack{
            if self.isActive{
                ContactMainView()
            }else{
                SplashScreen()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
