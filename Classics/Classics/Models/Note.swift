//
//  Task.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import Foundation


struct Note : Codable, Hashable{
    let time : Date
    let progress : Int
    var modified : Bool
    var noteBody : String
    
    enum CodingKeys : String, CodingKey {
        case time
        case progress
        case modified
        case noteBody
    }
    
    func timeToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"// yyyy-MM-dd"
        return dateFormatter.string(from: self.time)
    }
}
