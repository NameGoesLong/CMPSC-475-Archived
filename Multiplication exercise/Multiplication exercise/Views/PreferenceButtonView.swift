//
//  SettingButton.swift
//  Multiplication exercise
//
//  Created by New User on 13/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PreferenceButtonView : View {
    @State private var isShowingPreference = false
    @Binding var exerciseModel : ExerciseModel
    
    var body: some View {
   
        Button(action: { self.isShowingPreference.toggle() }) {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.black)
                .padding(10)
        }.sheet(isPresented: $isShowingPreference) {
            PreferenceView(isShowingPreference: self.$isShowingPreference, questionNumber: self.$exerciseModel.preference_item.QuestionRounds, preference: self.$exerciseModel.preference_item)
            
        }
        
    }
}
