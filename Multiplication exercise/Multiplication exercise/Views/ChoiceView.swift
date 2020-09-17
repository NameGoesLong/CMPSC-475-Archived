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
    //@Binding var isQuestPage :Bool
    var body: some View{
        HStack{
            ForEach(exerciseModel.selection, id: \.self){ choice in
                Button("\(choice)"){
                    //self.isQuestPage.toggle()
                    self.exerciseModel.checkCorrectness(choice)
                }
                    .frame(width: 32.0)
                    .padding().background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray).opacity(0.2))
            }
            .padding(.top)
        }
    }
}
