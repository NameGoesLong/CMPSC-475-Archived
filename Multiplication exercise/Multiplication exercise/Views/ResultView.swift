//
//  ResultView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ResultView: View{
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    
    var currentCorrectnessColorBinding : Color {
        exerciseViewModel.currentCorrectness == "correct" ? Color.green : Color.red
    }
    var body: some View{
        VStack{
            Text(exerciseViewModel.currentCorrectness).font(.system(size: 45, weight: .bold)).fontWeight(.bold).foregroundColor(currentCorrectnessColorBinding).multilineTextAlignment(.center).padding(.all).opacity(exerciseViewModel.isSummaryPage ? 0.0 : 1.0)
            Text(exerciseViewModel.analysis)
                .padding(.all)
            Button(exerciseViewModel.resultButtonText){
                self.exerciseViewModel.nextProblem()
            } .foregroundColor(Color.white)
                .padding(.all).background(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        
    }
}
