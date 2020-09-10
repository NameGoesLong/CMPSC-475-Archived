//
//  MultiplicationProblemModel.swift
//  Multiplication exercise
//
//  Created by New User on 9/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

enum Correctness{
    case wrong, correct, pending
}

//This is the model of a single multiplication problem
struct MultiplicationProblemModel{
    private let selectionNumber = 4
    var multiplicand : Int
    var multiplier : Int
    var result : Int
    var selection : [Int] {generateSelections(result)}
    var correctness : Correctness
    
    init() {
        multiplicand = Int.random(in: 1...15)
        multiplier = Int.random(in: 1...15)
        result = multiplicand * multiplier
        correctness = .pending
    }
    
    //Generate selection and return them in ascending order
    private func generateSelections(_ Answer: Int) ->[Int]{
        let bottom = (Answer - 5) > 1 ? Answer - 5 : 1
        var selectionRange = Set((bottom) ... (Answer + 5))
        var temp: [Int] = [result]
        
        selectionRange.remove(result)
        for _ in (1..<selectionNumber) {
            let e = selectionRange.randomElement() ?? 1
            temp.append(e)
            selectionRange.remove(e)
        }
        temp.sort()
        return temp
    }
    
    //Helper function to convert the result of a problem into icons
    func computeCorrectness() ->String{
        switch correctness{
        case .correct: return "✔️"
        case .wrong: return "❌"
        default:return "    "
        }
    }
}
