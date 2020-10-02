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
    var captured : Bool
    
    
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
    
    var  allPokemon : AllPokemon{
        didSet {
            saveData()
        }
    }
    
    let destinationURL : URL
    
    init() {
        
        let filename = "pokedex-v2"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allPokemon = try decoder.decode(AllPokemon.self, from: data)
        } catch  {
           print("Error info: \(error)")
            allPokemon = []
        }
      
        
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data  = try encoder.encode(allPokemon)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
    }
    
    var typeTitles: [PokemonType] {
        //let alltypes = Set(allPokemon.flatMap({ $0.types }))
        //return alltypes.sorted{$0.id < $1.id}
        return PokemonType.allCases
    }
    
    func pokemonIDs(for property: (Pokemon) -> Bool) -> [Int] {
        let filteredPokemon = allPokemon.filter(property)
        let indices = filteredPokemon.map {p in allPokemon.firstIndex(where: {$0.id == p.id})!}
        return indices
    }
    
}
