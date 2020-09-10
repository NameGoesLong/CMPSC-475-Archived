//
//  ScoreView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    var body: some View{
        VStack{
            HStack{
                ForEach(exerciseViewModel.ScoreList, id: \.self){i in
                    Text(i)
                }.padding(2.0).background(Circle().fill(Color.gray).opacity(0.4))
            }
            .padding(.vertical)
            Text("\(exerciseViewModel.totalCorrectness)/5")
                .padding(.vertical)
            
        }
        
    }
}
