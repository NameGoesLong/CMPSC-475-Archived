//
//  SplashScreen.swift
//  Tag
//
//  Created by New User on 8/12/20.
//

import SwiftUI

struct SplashScreen: View {
    let fuberBlue = Color("Fuber blue")
    
    var body: some View {
        ZStack {
            Text("T A G")
                .font(.largeTitle)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .foregroundColor(.white)
                .background(fuberBlue)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
