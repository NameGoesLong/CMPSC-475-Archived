//
//  PokemonDetailView.swift
//  PokemonHelper
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PokemonDetailView : View {
    var pokemon : Pokemon
    var body: some View{
            List{
                Image(pokemon.getFormattedId()).resizable().aspectRatio(contentMode: .fit).padding(40.0).background(RoundedRectangle(cornerRadius: 20).fill(Color.gray)).overlay(Text(pokemon.getFormattedId()).font(.subheadline).foregroundColor(Color.white).padding(.all), alignment: .bottomTrailing).padding(20.0)
                VStack{
                    Text("Height: \(String(format: "%g", pokemon.height)) m")
                    Text("Weight: \(String(format: "%g", pokemon.weight)) kg")
                }
                VStack{
                    Text("Types")
                    ScrollView(.horizontal){
                        HStack(spacing: 10.0){
                            ForEach(pokemon.types, id: \.self){ type in
                                Text(type.rawValue).padding(10.0).frame(minWidth: 50.0).background(RoundedRectangle(cornerRadius: 50).fill(Color(pokemonType: type)).opacity(0.2))
                            }
                        }
                    }
                    
                }
                VStack{
                    Text("Weaknesses")
                    ScrollView(.horizontal){
                        HStack(spacing: 10.0){
                            ForEach(pokemon.weaknesses, id: \.self){ weakness in
                                Text(weakness.rawValue).padding(10.0).frame(minWidth: 50.0).background(RoundedRectangle(cornerRadius: 50).fill(Color(pokemonType: weakness)).opacity(0.2))
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text(pokemon.name),displayMode: .automatic)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var pokemons = Pokemons()
    static var previews: some View {
        PokemonDetailView(pokemon: pokemons.allPokemon[0])
    }
}
