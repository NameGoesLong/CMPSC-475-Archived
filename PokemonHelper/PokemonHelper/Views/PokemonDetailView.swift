//
//  PokemonDetailView.swift
//  PokemonHelper
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PokemonDetailView : View {
    @Binding var pokemon: Pokemon
    @Binding var pokedex: Pokedex
    var body: some View{
        List{
                Button(action:{pokemon.captured.toggle()}){
                    pokemon.captured ? Text("Mark it as freed") : Text("Mark it as captured")
                }.padding(.top).buttonStyle(ResultButtonStyle())
                
                Image(pokemon.getFormattedId()).resizable().aspectRatio(contentMode: .fit).padding(40.0).background(RoundedRectangle(cornerRadius: 20).fill(Color.gray)).overlay(Text(pokemon.getFormattedId()).font(.subheadline).foregroundColor(Color.white).padding(.all), alignment: .bottomTrailing).padding(20.0)
                
                VStack{
                    Text("Height: \(String(format: "%g", pokemon.height)) m")
                    Text("Weight: \(String(format: "%g", pokemon.weight)) kg")
                }
                
            VStack(alignment: .leading){
                    Text("Types").font(.headline)
                    ScrollView(.horizontal){
                        HStack(spacing: 10.0){
                            ForEach(pokemon.types, id: \.self){ type in
                                Text(type.rawValue).padding(10.0).frame(minWidth: 50.0).background(RoundedRectangle(cornerRadius: 50).fill(Color(pokemonType: type)).opacity(0.2))
                            }
                        }
                    }

                }
                
            VStack(alignment: .leading){
                    Text("Weaknesses").font(.headline)
                    ScrollView(.horizontal){
                        HStack(spacing: 10.0){
                            ForEach(pokemon.weaknesses, id: \.self){ weakness in
                                Text(weakness.rawValue).padding(10.0).frame(minWidth: 50.0).background(RoundedRectangle(cornerRadius: 50).fill(Color(pokemonType: weakness)).opacity(0.2))
                            }
                        }
                    }
                }
                
                if((pokemon.prev_evolution) != nil){
                    VStack(alignment: .leading){
                        CategoryRow(pokedex: $pokedex, categoryName: "Evolves From", property: {pokemon.prev_evolution!.contains($0.id)})
                    }
                }
                
                if((pokemon.next_evolution) != nil){
                    VStack(alignment: .leading){
                        CategoryRow(pokedex: $pokedex, categoryName: "Evolves Into", property: {pokemon.next_evolution!.contains($0.id)})
                    }
                }
            }.navigationBarTitle(Text(pokemon.name),displayMode: .automatic)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    @State static var pokemon = Pokedex().allPokemon[0]
    @State static var pokedex = Pokedex()
    static var previews: some View {
        PokemonDetailView(pokemon: $pokemon, pokedex: $pokedex)
    }
}
