//
//  ContentView.swift
//  Multiplication exercise
//
//  Created by New User on 31/8/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        NavigationView{
            ZStack{
                // A defected way of giving NavigationView a background
                Color.gray.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .trailing, spacing: 100){
                    Text("SwiftUI Multiplication").font(.system(size: 45, weight: .bold, design: .rounded)).multilineTextAlignment(.trailing).padding(20.0).background(RoundedRectangle(cornerRadius: 50).fill(Color.blue).opacity(0.2))
                    NavigationLink(destination: GameRootView()){
                        Text("START").font(.system(size: 25, weight: .bold, design: .rounded)).padding(10.0).background(Capsule().stroke(lineWidth: 2))
                    }
                }
            }
        }.foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
