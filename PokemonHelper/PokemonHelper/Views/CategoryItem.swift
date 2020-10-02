//
//  CategoryItem.swift
//  PokemonHelper
//
//  Created by New User on 30/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    @Binding var pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(pokemon.getFormattedId()).renderingMode(.original).resizable().scaledToFill().frame(width: frameSize, height: frameSize).padding(.vertical,20.0).background(RoundedRectangle(cornerRadius: 20).fill(Color.gray)).overlay(Text(pokemon.name).font(.subheadline).foregroundColor(Color.white).padding(.bottom,5.0), alignment: .bottom)
        }
        .padding(.leading, 15)
    }
    
    let frameSize : CGFloat = 155
}

struct CategoryItem_Previews: PreviewProvider {
    @State static var pokemon = Pokedex().allPokemon[0]
    static var previews: some View {
        CategoryItem(pokemon: $pokemon)
    }
}
