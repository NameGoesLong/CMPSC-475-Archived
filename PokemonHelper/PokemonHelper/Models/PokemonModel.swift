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
    let height : Double
    let weight : Double
    let weaknesses : [PokemonType]
    let prev_evolution : [Int]?
    let next_evolution : [Int]?
    let captured : Bool
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weaknesses
        case prev_evolution
        case next_evolution
        case captured
    }
    
    func getFormattedId () -> String{
        return String(format: "%03d", id)
    }
}

typealias AllPokemon = [Pokemon]

struct Pokedex  {
    
    var  allPokemon : AllPokemon
    
    init() {
        
        let filename = "pokedex-v2"
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
