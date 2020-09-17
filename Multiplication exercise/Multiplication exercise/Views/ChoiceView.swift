//
//  ChoiceView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

//View for button selection
struct ChoiceView: View{
    @Binding var exerciseModel : ExerciseModel

    var body: some View{
        HStack{
            ForEach(exerciseModel.currentProblemSelections, id: \.self){ choice in
                Button("\(choice)"){
                    self.exerciseModel.checkCorrectness(choice)
                }
            .buttonStyle(SelectionButtonStyle())
            }
            .padding(.top)
        }
    }
}
