//
//  Category.swift
//  PokemonHelper
//
//  Created by New User on 1/10/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct Categories: View {
    @EnvironmentObject var pokedex : Pokedex
    var body: some View {
        
        Group {
            //Category row for Captured pokemons, show if the list is non empty
            if(pokedex.pokemonIDs(for: {$0.captured}).count > 0){
                CategoryRow(categoryName: "Captured", property: {$0.captured}).environmentObject(pokedex)
            }
            //Category rows by pokemonTypes
            ForEach(pokedex.typeTitles, id:\.self) { typeTitle in
                CategoryRow(categoryName: typeTitle.rawValue, property: {$0.types.contains(typeTitle)}).environmentObject(pokedex)
            }
        }
    }
}

struct Categories_Previews: PreviewProvider {
    @State static var pokedex = Pokedex()
    static var previews: some View {
        Categories().environmentObject(pokedex)
    }
}

