//
//  MainView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI


struct MainView: View {
    @Binding var exerciseModel : ExerciseModel
    
    var body: some View{
        VStack{
            ScoreView(exerciseModel: $exerciseModel)
                .padding(.vertical)
            ZStack{
                QuestView(exerciseModel: $exerciseModel).padding(.top).opacity(exerciseModel.exerciseViewState == .question ? 1.0 : 0.0).disabled(exerciseModel.exerciseViewState == .question ? false : true)
                
                ResultView(exerciseModel: $exerciseModel).opacity(exerciseModel.exerciseViewState == .result ? 1.0 : 0.0).disabled(exerciseModel.exerciseViewState == .result ? false : true)
                
                SummaryView(exerciseModel: $exerciseModel).opacity(exerciseModel.exerciseViewState == .summary ? 1.0 : 0.0).disabled(exerciseModel.exerciseViewState == .summary ? false : true)
            }
        }
    }
}
