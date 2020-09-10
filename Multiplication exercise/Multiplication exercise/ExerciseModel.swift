//
//  Exercise.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

struct ExerciseModel {
    private let QuestionRounds = 5
    private var totalPhase :Int {1 + QuestionRounds * 2}
    
    private var currentPhase = 1
    var current : Int
    var isQuestPage : Bool {currentPhase % 2 == 1}
    mutating func incrementPhaseCount() {
        currentPhase = (currentPhase + 1) % (totalPhase)
    }
    
    var isSummaryPage : Bool {currentPhase == 0}
    
    var problemSet : [MultiplicationProblemModel]
    var currentProblem : MultiplicationProblemModel {problemSet[current]}
    
    var correctness: Int = 0
    
    var resultButtonText : String {currentPhase == 0 ? "Reset" : "Next Question"}
    var analysis: String {
        if isSummaryPage{
            return "You have finished all the problem(s)."
        }else{
            return "The correct answer is :" + String(currentProblem.result)
        }
    }
    
    init() {
        problemSet = [MultiplicationProblemModel]()
        for _ in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel())
        }
        current = 0
    }
    
    mutating func resetProblemSet(){self = ExerciseModel()}
    
    mutating func getNextProblem(){
        if currentPhase == 0{
            resetProblemSet()
        }else{
            incrementPhaseCount()
        }
        current = Int(self.currentPhase / 2)
    }
    
    
    mutating func checkCorrectness(_ Answer: Int){
        incrementPhaseCount()
        if Answer == currentProblem.result{
            correctness = correctness + 1
            problemSet[current].correctness = .correct
        }else{
            problemSet[current].correctness = .wrong
        }
    }
}
