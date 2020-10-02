//
//  PokemonDetailView.swift
//  PokemonHelper
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct PokemonDetailView : View {
    @EnvironmentObject var pokedex : Pokedex
    @Binding var pokemon: Pokemon
    var body: some View{
        List{
            // Capture/Free button
            HStack{
                Spacer()
                Button(action:{pokedex.allPokemon[pokemon.id - 1].captured.toggle()}){
                    pokemon.captured ?
                        Text("Mark it as freed")
                        : Text("Mark it as captured")
                }.padding(.top)
                .buttonStyle(ResultButtonStyle())
                Spacer()
            }
            
            //Image for pokemon. Turned grey when not captured, the background become the color of the first of its types when captured
            Image(pokemon.getFormattedId())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(pokemon.captured ? Color(pokemonType: pokemon.types[0]): Color.gray)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                )
                .overlay(
                    Text(pokemon.getFormattedId())
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.all),
                    alignment: .bottomTrailing)
                .padding(20.0)
                .grayscale(pokemon.captured ? 0.0 : 0.99)
            
            //Text for height and weight
            VStack(alignment: .leading){
                Text("Height: \(String(format: "%g", pokemon.height)) m").font(.headline)
                Text("Weight: \(String(format: "%g", pokemon.weight)) kg").font(.headline)
            }
            
            // Showing its Types
            VStack(alignment: .leading){
                Text("Types").font(.headline)
                ScrollView(.horizontal){
                    HStack(spacing: 10.0){
                        ForEach(pokemon.types, id: \.self){ type in
                            Text(type.rawValue)
                                .padding(10.0)
                                .frame(minWidth: 50.0)
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color(pokemonType: type))
                                        .opacity(0.2))
                        }
                    }
                }
                
            }
            
            // Showing its Weakness
            VStack(alignment: .leading){
                Text("Weaknesses").font(.headline)
                ScrollView(.horizontal){
                    HStack(spacing: 10.0){
                        ForEach(pokemon.weaknesses, id: \.self){ weakness in
                            Text(weakness.rawValue)
                                .padding(10.0)
                                .frame(minWidth: 50.0)
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color(pokemonType: weakness))
                                        .opacity(0.2))
                        }
                    }
                }
            }
            
            //Showing its prev_evolution, if any
            if((pokemon.prev_evolution) != nil){
                VStack(alignment: .leading){
                    CategoryRow(categoryName: "Evolves From", property: {pokemon.prev_evolution!.contains($0.id)}).environmentObject(pokedex)
                }
            }
            
            //Showing its next_evolution, if any
            if((pokemon.next_evolution) != nil){
                VStack(alignment: .leading){
                    CategoryRow(categoryName: "Evolves Into", property: {pokemon.next_evolution!.contains($0.id)}).environmentObject(pokedex)
                }
            }
        }.navigationBarTitle(Text(pokemon.name),displayMode: .automatic)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    @State static var pokemon = Pokedex().allPokemon[0]
    @State static var pokedex = Pokedex()
    static var previews: some View {
        PokemonDetailView(pokemon: $pokemon)
    }
}
