//
//  GameRootView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI


struct GameRootView: View{
    @State private var exerciseModel  = ExerciseModel()
    var body: some View {
    VStack(alignment: .center){
        HStack{
            VStack(alignment: .leading){
                Text("Operation: \(exerciseModel.problemSetOperation)").foregroundColor(Color.white.opacity(0.4))
                Text("Difficulty: \(exerciseModel.problemSetDifficulty)").foregroundColor(Color.white.opacity(0.4))
            }
            Spacer()
            PreferenceButtonView(exerciseModel: $exerciseModel)
        }
        TitleView().padding(.top)
        Spacer()
        MainView(exerciseModel: $exerciseModel).padding(.vertical)
        Spacer()
    }.frame( maxWidth: .infinity, maxHeight: .infinity).background(ViewConstants.backgroundColor).foregroundColor(ViewConstants.textColor).navigationBarBackButtonHidden(true)
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
