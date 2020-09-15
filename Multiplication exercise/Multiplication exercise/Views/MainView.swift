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
    @State private var isQuestPage = true
    
    var body: some View{
        VStack{
            ScoreView(exerciseModel: $exerciseModel)
                .padding(.vertical)
            ZStack{
                QuestView(exerciseModel: $exerciseModel, isQuestPage: $isQuestPage).padding(.top).opacity(isQuestPage ? 1.0 : 0.0).disabled(isQuestPage ? false : true)
                ResultView(exerciseModel: $exerciseModel, isQuestPage: $isQuestPage).opacity(isQuestPage ? 0.0 : 1.0).disabled(isQuestPage ? true : false)
            }
            
        }
    }
}
