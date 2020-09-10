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
            VStack{
                Text("SwiftUI multiplication")
                NavigationLink(destination: GameRootView()){
                    Text("start")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ExerciseViewModel())
    }
}
