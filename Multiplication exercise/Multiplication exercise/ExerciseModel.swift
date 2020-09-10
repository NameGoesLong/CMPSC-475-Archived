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
    
    var problemSet : [MultiplicationProblemModel]
    var currentProblem : MultiplicationProblemModel {problemSet[current]}
    
    var correctness: Int = 0
    
    //Change the output of the view accodring to the page it should show
    var isSummaryPage : Bool {currentPhase == 0}
    var resultButtonText : String {isSummaryPage ? "Reset" : "Next Question"}
    var analysis: String {
        if isSummaryPage{
            return "You have finished all the problem(s)."
        }else{
            return "The correct answer is :" + String(currentProblem.result)
        }
    }
    
    //initialize the problem set for another round
    init() {
        problemSet = [MultiplicationProblemModel]()
        for _ in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel())
        }
        current = 0
    }
    
    mutating func resetProblemSet(){self = ExerciseModel()}     //This is the easiest wat of resetting all the data
    
    mutating func getNextProblem(){
        if currentPhase == 0{
            resetProblemSet()   //call init() if the program goes to another round
        }else{
            incrementPhaseCount()
        }
        current = Int(self.currentPhase / 2)        //Calculate the problem number only when we are trying to get the next problem
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
