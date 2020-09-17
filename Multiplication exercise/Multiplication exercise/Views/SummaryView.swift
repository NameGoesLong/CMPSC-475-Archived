//
//  SummaryView.swift
//  Multiplication exercise
//
//  Created by New User on 16/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct SummaryView: View{
    @Binding var exerciseModel : ExerciseModel
    //@Binding var isQuestPage : Bool
    
    var currentCorrectnessColorBinding : Color {
        exerciseModel.currentCorrectness == "correct" ? Color.green : Color.red
    }
    var body: some View{
        VStack{
            Text(exerciseModel.analysis)
                .padding(.all)
            Button(exerciseModel.resultButtonText){
                self.exerciseModel.resetProblemSet()
            } .foregroundColor(Color.white)
                .padding(.all).background(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        
    }
}
