//
//  PreferenceModel.swift
//  Multiplication exercise
//
//  Created by New User on 14/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

enum Operation : String, CaseIterable, Identifiable{
    var id: String { self.rawValue }
    case addition, multiplicaiton
}

enum Difficulty : String, CaseIterable, Identifiable{
    var id: String { self.rawValue }
    case easy, normal, difficult
}

struct PreferenceModel{
    var operation : Operation
    var difficulty : Difficulty
    var QuestionRounds : Int
    
    init(operation: Operation = .multiplicaiton, difficulty: Difficulty = .easy){
        self.operation = operation
        self.difficulty = difficulty
        QuestionRounds = 5
    }
}
