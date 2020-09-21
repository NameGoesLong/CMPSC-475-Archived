//
//  PokemonRowView.swift
//  Pokédex
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PokemonRowView : View {
    var pokemon : Pokemon
    var body: some View{
        HStack{
            Text(pokemon.getFormattedId())
            Text(pokemon.name)
            Spacer()
            Image(pokemon.getFormattedId()).resizable().aspectRatio(contentMode: .fit)
                .frame(height: 40, alignment: .center)
        }
    }
}
