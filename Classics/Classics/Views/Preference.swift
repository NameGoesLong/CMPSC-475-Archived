//
//  Preference.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import SwiftUI

enum SelectionMode : String, CaseIterable {
    case Default
    case CurrentlyReading
    case FinishedReading
}

struct Preferences: View {
    @Binding var typeIndex : SelectionMode
    var body: some View {
        Picker(selection: $typeIndex, label:Text("Filter")){
            ForEach(SelectionMode.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(MenuPickerStyle())
    }
}
