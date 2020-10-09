//
//  CampusBuildings.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import Foundation
import CoreLocation

struct Building : Codable, Identifiable{
    let id = UUID()
    let latitude : Double
    let longitude : Double
    let name : String
    let buildingCode : Int
    let yearConstructed : Int?
    let photo : String
    var favorite : Bool
    
    var coordinate : CLLocationCoordinate2D
    
    enum CodingKeys : String, CodingKey {
        case latitude
        case longitude
        case name
        case buildingCode = "opp_bldg_code"
        case yearConstructed = "year_constructed"
        case photo
        case favorite
    }
    
    // Create custom decoder to add favorite attributes to the model
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
        if let photo = try container.decodeIfPresent(String.self, forKey: .photo){
            self.photo = photo
        }else{
            self.photo = "defaultbuilding"
        }
        if let favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite){
            self.favorite = favorite
        }else{
            self.favorite = false
        }
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

typealias AllBuildings = [Building]

struct CampusBuildings{
    
    var allBuildings : AllBuildings
    
    //MARK: - Locations
    // Centered in State College -- somewhat
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.8005644421705, longitude: -77.8604697928673)
    static let span : CLLocationDegrees = 0.02
        
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
    
    func buildingTitles(using titleFor: (Building) -> String) -> [String] {
        let titles = Set(allBuildings.map(titleFor))
        return titles.sorted()
    }
    

    func stateIndices(for property: (Building) -> Bool) -> [Int] {
        let filteredBuildings = allBuildings.filter(property)
        let indices = filteredBuildings.map {s in allBuildings.firstIndex(where: {$0.name == s.name})!}
        return indices
    }
    
}
