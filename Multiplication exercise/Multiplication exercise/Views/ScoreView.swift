//
//  ScoreView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    @Binding var exerciseModel : ExerciseModel
    var body: some View{
        VStack{
            HStack{
                ForEach(exerciseModel.ScoreList, id: \.self){i in
                    Text(i)
                }.padding(2.0).background(Circle().fill(Color.gray).opacity(0.4))
            }
            .padding(.vertical)
            Text("\(exerciseModel.correctness)/\(exerciseModel.QuestionRounds)")
                .padding(.vertical)
            
        }
        
    }
}
