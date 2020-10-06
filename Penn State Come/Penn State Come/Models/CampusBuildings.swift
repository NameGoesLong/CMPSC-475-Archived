//
//  CampusBuildings.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import Foundation

struct Building : Codable{
    let id = UUID()
    let latitude : Double
    let longitude : Double
    let name : String
    let buildingCode : Int
    let yearConstructed : Int?
    var favorite : Bool
    
    enum CodingKeys : String, CodingKey {
        case latitude
        case longitude
        case name
        case buildingCode = "opp_bldg_code"
        case yearConstructed = "year_constructed"
        case favorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        name = try container.decode(String.self, forKey: .name)
        buildingCode = try container.decode(Int.self, forKey: .buildingCode)
        if let yearConstructed = try container.decodeIfPresent(Int.self, forKey: .yearConstructed){
            self.yearConstructed = yearConstructed
        }else{
            self.yearConstructed = nil
        }
        if let favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite){
            self.favorite = favorite
        }else{
            self.favorite = false
        }
    }
}

typealias AllBuildings = [Building]

class CampusBuildings: ObservableObject {
    
    var allBuildings : AllBuildings
    
    let destinationURL : URL
    
    init() {
        
        let filename = "buildings"
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
            allBuildings = try decoder.decode(AllBuildings.self, from: data)
        } catch  {
           print("Error info: \(error)")
            allBuildings = []
        }
      
        
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data  = try encoder.encode(allBuildings)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
    }
}
