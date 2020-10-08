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
    
    var allBuildings : AllBuildings{
        didSet {
            saveData()
        }
    }
    
    // Map will annotate these items
    var pinnedBuildingsList = [Building]()
    
    //MARK: - Locations
    // Centered in downtown State College
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.8005644421705, longitude: -77.8604697928673)
    static let span : CLLocationDegrees = 0.02
    
    // define 4 corner points of downtown State College
    static let campusCoordinates = [(40.791831951313,-77.865203974557),
                                      (40.800364570711,-77.853778542571),
                                      (40.799476294037,-77.8525124806654),
                                      (40.7908968034537,-77.8638607142546)].map {(a,b) in CLLocationCoordinate2D(latitude: a, longitude: b)}
    
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
        
//        for i in 1..<10{
//            pinnedBuildingsList.append(allBuildings[i])
//        }
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
    
    func annotatedBuildings() ->[Building]{
        return pinnedBuildingsList
    }
    
//    mutating func pinBuilding(id: Int){
//        pinnedBuildingsList.append(allBuildings[id - 1])
//    }
}
