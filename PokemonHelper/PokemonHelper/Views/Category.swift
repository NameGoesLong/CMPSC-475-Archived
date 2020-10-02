//
//  Category.swift
//  PokemonHelper
//
//  Created by New User on 1/10/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct Categories: View {
    @Binding var pokedex : Pokedex
    var body: some View {
        
        Group {
            if(CategoryRow(pokedex: $pokedex, categoryName: "Captured", property: {$0.captured}).nonEmpty){
                CategoryRow(pokedex: $pokedex, categoryName: "Captured", property: {$0.captured})
            }
            ForEach(pokedex.typeTitles, id:\.self) { typeTitle in
                CategoryRow(pokedex: $pokedex, categoryName: typeTitle.rawValue, property: {$0.types.contains(typeTitle)})
            }
        }
    }
}

struct Categories_Previews: PreviewProvider {
    @State static var pokedex = Pokedex()
    static var previews: some View {
        Categories(pokedex: $pokedex)
    }
}

