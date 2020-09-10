//
//  MainView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    
    var body: some View{
        VStack{
            ScoreView()
                .padding(.vertical).environmentObject(exerciseViewModel)
            ZStack{
                QuestView().padding(.top).environmentObject(exerciseViewModel).opacity(exerciseViewModel.currentPage ? 1.0 : 0.0).disabled(exerciseViewModel.currentPage ? false : true)
                ResultView().environmentObject(exerciseViewModel).opacity(exerciseViewModel.currentPage ? 0.0 : 1.0).disabled(exerciseViewModel.currentPage ? true : false)
            }
            
        }
    }
}
