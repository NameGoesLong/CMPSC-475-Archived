//
//  Preference.swift
//  PokemonHelper
//
//  Created by New User on 1/10/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct Preferences: View {
    @Binding var typeIndex : PokemonType?
    var body: some View {
        Picker(selection: $typeIndex, label:Text("Filter")){
            Text("All").tag(nil as PokemonType?)
            ForEach(PokemonType.allCases, id: \.id) { value in
                Text(value.rawValue).tag(value as PokemonType?)
            }
        }.pickerStyle(MenuPickerStyle())
    }
}
