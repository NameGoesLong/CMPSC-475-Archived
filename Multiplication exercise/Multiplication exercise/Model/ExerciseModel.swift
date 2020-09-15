//
//  Exercise.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

struct ExerciseModel {
    var QuestionRounds : Int
    private var totalPhase :Int {1 + QuestionRounds * 2}
    
    private var currentPhase = 1
    var current : Int
    //var isQuestPage : Bool {currentPhase % 2 == 1}
    var currentQuestionNumber : Int {current + 1}
    mutating func incrementPhaseCount() {
        currentPhase = (currentPhase + 1) % (totalPhase)
    }
    
    var preference_item : PreferenceModel = PreferenceModel(){
        didSet{
            resetProblemSet()
        }
    }
    
    var problemSet : [MultiplicationProblemModel]
    var currentProblem : MultiplicationProblemModel {problemSet[current]}
    var current_multiplicand : String {String(currentProblem.multiplicand)}
    var current_multiplier : String {String(currentProblem.multiplier)}
    var selection : [Int] {currentProblem.selection}
    var exercise_operator : String {
    if preference_item.operation == .addition{
        return "+"
    }else{
        return "X"
    }
    }
    
    var correctness: Int
    var currentCorrectness: String {String(describing: currentProblem.correctness)}
    var ScoreList : [String]{problemSet.map{$0.computeCorrectness()}}
    
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
        QuestionRounds = preference_item.QuestionRounds
        for _ in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel(preference_item.operation, preference_item.difficulty))
        }
        current = 0
        correctness = 0
    }
    
    //mutating func resetProblemSet(){self = ExerciseModel()}     //This is the easiest wat of resetting all the data
    mutating func resetProblemSet(){
        problemSet = [MultiplicationProblemModel]()
        QuestionRounds = preference_item.QuestionRounds
        for _ in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel(preference_item.operation, preference_item.difficulty))
        }
        current = 0
        correctness = 0
        currentPhase = 1
    }
    
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
