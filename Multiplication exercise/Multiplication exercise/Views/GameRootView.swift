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
    }.frame( maxWidth: .infinity, maxHeight: .infinity).background(Color(red: 29/255.0, green: 53/255.0, blue: 87/255.0, opacity: 0.7)).foregroundColor(Color.orange).navigationBarBackButtonHidden(true)
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
