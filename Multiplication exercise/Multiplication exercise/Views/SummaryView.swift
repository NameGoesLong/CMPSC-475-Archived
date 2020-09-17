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
    
    var body: some View{
        VStack{
            Text(ViewConstants.summary)
                .padding(.all)
            Button(ViewConstants.summaryButtonText){
                self.exerciseModel.resetProblemSet()
            } .buttonStyle(ResultButtonStyle())
        }
        
    }
}
