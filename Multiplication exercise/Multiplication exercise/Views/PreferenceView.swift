//
//  SettingView.swift
//  Multiplication exercise
//
//  Created by New User on 13/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PreferenceView : View {
    @Binding var isShowingPreference : Bool
    @Binding var questionNumber : Int
    @Binding var preference : PreferenceModel
    var body: some View{
        NavigationView {
            Form {
                Section(header: Text("Arthimetic operation")) {
                    VStack {
                        Picker("Operation", selection: $preference.operation) {
                            ForEach(Operation.allCases){
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("Selected value is: \(preference.operation.rawValue)").padding()
                    }
                }
                
                Section(header: Text("Difficulty")) {
                    VStack {
                        Picker("Difficulty", selection: $preference.difficulty) {
                            ForEach(Difficulty.allCases) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("Selected value is: \(preference.difficulty.rawValue)").padding()
                    }
                }
                Section(header: Text("Number of questions")) {
                    Stepper(value: $questionNumber,
                            in: 3...7,
                            label: {
                                Text("\(self.questionNumber) questions")
                    })
                }
                
                Section() {
                    HStack {
                        Spacer()
                        Button("Return to main"){
                            self.isShowingPreference.toggle()
                        }
                        Spacer()
                    }
                }.navigationBarTitle("Setting")
            }
        }
        
    }
    
}
