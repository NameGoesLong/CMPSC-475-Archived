//
//  Task.swift
//  Classics
//
//  Created by New User on 19/10/20.
//

import Foundation


struct Note : Codable, Hashable{
    let time : String
    let progress : Int
    var modified : Bool
    var noteBody : String
    
    enum CodingKeys : String, CodingKey {
        case time
        case progress
        case modified
        case noteBody
    }
}
