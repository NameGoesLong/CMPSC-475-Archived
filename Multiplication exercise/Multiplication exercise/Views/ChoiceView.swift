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
                Button("\(choice)"){self.exerciseViewModel.getSelectedAnswer(choice)}.padding(.all, 10.0).background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).opacity(0.5)).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .padding(.top)
        }
    }
}
