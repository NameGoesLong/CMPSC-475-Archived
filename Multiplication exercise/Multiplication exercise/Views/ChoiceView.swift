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
    @EnvironmentObject var exerciseViewModel : ExerciseViewModel
    var body: some View{
        HStack{
            ForEach(exerciseViewModel.selection, id: \.self){ choice in
                Button("\(choice)"){self.exerciseViewModel.getSelectedAnswer(choice)}
                    .frame(width: 32.0)
                    .padding().background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray).opacity(0.2))
            }
            .padding(.top)
        }
    }
}
