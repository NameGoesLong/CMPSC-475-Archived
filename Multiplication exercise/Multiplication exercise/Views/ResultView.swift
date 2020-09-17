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
    private var currentCorrectnessColorBinding : Color {
        exerciseModel.currentCorrectness == "correct" ? ViewConstants.approveColor : ViewConstants.denyColor
    }
    
    var body: some View{
        VStack{
            Text(exerciseModel.currentCorrectness).font(.system(size: 45, weight: .bold)).fontWeight(.bold).foregroundColor(currentCorrectnessColorBinding).multilineTextAlignment(.center).padding(.all)
            Text(exerciseModel.currentProblemAnalysis)
                .padding(.all)
            Button(ViewConstants.resultButtonText){
                self.exerciseModel.getNextProblem()
                } .buttonStyle(ResultButtonStyle())
        }
        
    }
}
