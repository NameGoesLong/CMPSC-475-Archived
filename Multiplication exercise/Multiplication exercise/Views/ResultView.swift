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
            Text(exerciseViewModel.currentCorrectness).font(.headline).fontWeight(.bold).foregroundColor(currentCorrectnessColorBinding).multilineTextAlignment(.center)
            Text(exerciseViewModel.analysis)
            Button(exerciseViewModel.resultButtonText){
                self.exerciseViewModel.nextProblem()
            }
        }
        
    }
}
