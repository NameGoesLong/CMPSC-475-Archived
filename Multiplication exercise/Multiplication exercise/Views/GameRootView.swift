//
//  GameRootView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI


struct GameRootView: View{
    //@EnvironmentObject var exerciseViewModel : ExerciseViewModel
    var body: some View {
    VStack(alignment: .center){
        Spacer()
        TitleView()
        Spacer()
        MainView()
            .padding(.vertical).environmentObject(ExerciseViewModel())
        Spacer()
        }.frame( maxWidth: .infinity, maxHeight: .infinity).background(Color.yellow.opacity(0.4)).foregroundColor(Color.pink.opacity(0.6)).navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


//Not used in Homework1
struct JudgeView: View{
    let result : Int
    var body: some View{
        VStack{
            if(result == 1){
                Text("Correct!")
            }else{
                Text("Wrong!")
            }
            Button("Next question"){}
        }
    }
}
