//
//  PokemonListView.swift
//  Pokédex
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//


import SwiftUI

struct PokemonListView : View {
    @Binding var pokedex : Pokedex
    @State var typeIndex : PokemonType? = nil
    
    var body: some View{
            List{
                ForEach(pokedex.pokemonIDs(for: {typeIndex==nil ? true : $0.types.contains(typeIndex!)}), id: \.self){ id in
                    NavigationLink(destination: PokemonDetailView(pokemon: self.$pokedex.allPokemon[id], pokedex: $pokedex)) {
                    PokemonRowView(pokemon: self.pokedex.allPokemon[id])
                    }
                }
            }.navigationBarTitle(typeIndex==nil ? "All Pokemon" : typeIndex!.rawValue)
            .navigationBarItems(trailing: Preferences(typeIndex: $typeIndex))
    }
}

