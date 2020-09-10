//
//  QuestView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

//View for showing the question
struct QuestView: View {
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    var problemId : Int = 3
    
    var body: some View{
        VStack{
            Text("Problem \(problemId)")
            VStack(alignment: .trailing){
                Text(exerciseViewModel.multiplier)
                Text("X \(exerciseViewModel.multiplicand)")
            }.padding(.top).font(.largeTitle)
            Rectangle().frame(width: 100.0, height: 7.0)
            ChoiceView().environmentObject(exerciseViewModel)
        }
    }
}
