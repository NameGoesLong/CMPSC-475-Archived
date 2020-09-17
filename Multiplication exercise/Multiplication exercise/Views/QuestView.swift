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
    @Binding var exerciseModel : ExerciseModel
    //@Binding var isQuestPage :Bool
    
    var body: some View{
        VStack{
            Text("Problem \(exerciseModel.currentQuestionNumber)")
            VStack(alignment: .trailing){
                Text(exerciseModel.current_multiplicand)
                Text("\(exerciseModel.exercise_operator) \(exerciseModel.current_multiplier)")
            }.padding(.top).font(.largeTitle)
            Rectangle().frame(width: 100.0, height: 7.0)
            ChoiceView(exerciseModel: $exerciseModel)
        }
    }
}
