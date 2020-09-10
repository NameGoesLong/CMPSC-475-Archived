//
//  ContentView.swift
//  Multiplication exercise
//
//  Created by New User on 31/8/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    var body: some View{
        NavigationView{
            ZStack{
                Color.gray.edgesIgnoringSafeArea(.all)
                VStack(alignment: .trailing, spacing: 100){
                    Text("SwiftUI Multiplication").font(.system(size: 45, weight: .bold, design: .rounded)).multilineTextAlignment(.trailing)
                    NavigationLink(destination: GameRootView()){
                        Text("START").font(.system(size: 25, weight: .bold, design: .rounded)).background(Capsule().stroke(lineWidth: 2)) 
                    }
                }
            }.background(Color(red: 29/255.0, green: 53/255.0, blue: 87/255.0, opacity: 0.7))
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true).foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ExerciseViewModel())
    }
}
