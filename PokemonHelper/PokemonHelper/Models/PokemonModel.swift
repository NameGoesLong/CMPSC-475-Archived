//
//  PokemonModel.swift
//  Pokédex
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

struct Pokemon : Codable {
    let id : Int
    let name : String
    let types : [PokemonType]
    let height : Float
    let weight : Float
    var weakness : [PokemonType]
    let next_evolution : [Int]
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weakness
        case next_evolution
    }
}

typealias AllPokemon = [Pokemon]

struct Pokemons  {
    
    var  allPokemon : AllPokemon
    
    init() {
        
        let filename = "pokedex"
        let mainBundle = Bundle.main
        let jsonURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            allPokemon = try decoder.decode(AllPokemon.self, from: data)
        } catch  {
           print("Error info: \(error)")
            allPokemon = []
        }
      
        
    }
}
