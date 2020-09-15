//
//  ResultView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ResultView: View{
    @Binding var exerciseModel : ExerciseModel
    @Binding var isQuestPage : Bool
    
    var currentCorrectnessColorBinding : Color {
        exerciseModel.currentCorrectness == "correct" ? Color.green : Color.red
    }
    var body: some View{
        VStack{
            Text(exerciseModel.currentCorrectness).font(.system(size: 45, weight: .bold)).fontWeight(.bold).foregroundColor(currentCorrectnessColorBinding).multilineTextAlignment(.center).padding(.all).opacity(exerciseModel.isSummaryPage ? 0.0 : 1.0)
            Text(exerciseModel.analysis)
                .padding(.all)
            Button(exerciseModel.resultButtonText){
                self.exerciseModel.getNextProblem()
                if(!self.exerciseModel.isSummaryPage){
                    self.isQuestPage.toggle()
                }
            } .foregroundColor(Color.white)
                .padding(.all).background(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        
    }
}
