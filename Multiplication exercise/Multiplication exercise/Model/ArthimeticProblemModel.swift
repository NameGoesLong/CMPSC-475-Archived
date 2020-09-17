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
struct ArthimeticProblemModel{
    private let selectionNumber = 4
    var id : Int
    var firstVariable : Int
    var secondVariable : Int
    var result : Int
    var selection : [Int] {generateSelections(result)}
    var correctness : Correctness
    
    init(_ id: Int, _ operation: Operation, _ difficulty: Difficulty) {
        self.id = id
        if operation == .addition{
            switch difficulty {
            case .easy:
                firstVariable = Int.random(in: 1...10)
                secondVariable = Int.random(in: 1...10)
            case .normal:
                firstVariable = Int.random(in: 7...99)
                secondVariable = Int.random(in: 7...99)
            case .difficult:
                firstVariable = Int.random(in: 50...999)
                secondVariable = Int.random(in: 50...999)
            }
            result = firstVariable + secondVariable
        }else{
            switch difficulty {
            case .easy:
                firstVariable = Int.random(in: 1...10)
                secondVariable = Int.random(in: 1...10)
            case .normal:
                firstVariable = Int.random(in: 7...15)
                secondVariable = Int.random(in: 7...15)
            case .difficult:
                firstVariable = Int.random(in: 12...30)
                secondVariable = Int.random(in: 12...30)
            }
            result = firstVariable * secondVariable
        }
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
