//
//  PokemonListView.swift
//  Pokédex
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//


import SwiftUI

struct PokemonListView : View {
    @State var pokemons = Pokemons()
    
    // Extracted from: https://developer.apple.com/forums/thread/122705
    init() {
        UITableView.appearance().backgroundColor = .green // Uses UIColor
    }
    
    var body: some View{
        NavigationView{
            List{
                ForEach(pokemons.allPokemon, id: \.self.id){ pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    PokemonRowView(pokemon: pokemon)
                    }
                }
            }.navigationBarTitle("Pokédex")
        }
        
    }
}


struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
