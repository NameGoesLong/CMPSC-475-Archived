//
//  Exercise.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

enum ExerciseViewState{
    case question, result, summary
}

struct ExerciseModel {
    var QuestionRounds : Int
    private var currentPhase = 1
    var current : Int
    var currentQuestionNumber : Int {currentProblem.id}

    
    var preference_item : PreferenceModel = PreferenceModel(){
        didSet{
            resetProblemSet()
        }
    }
    
    var exerciseViewState : ExerciseViewState {
        if isSummaryPage{
            return .summary
        }else{
            if currentProblem.correctness == .pending{
                return .question
            }else{
                return .result
            }
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
    
    var correctCount: Int {ScoreList.count(for: "✔️")}
    var currentCorrectness: String {String(describing: currentProblem.correctness)}
    var ScoreList : [String]{problemSet.map{$0.computeCorrectness()}}
    
    //Change the output of the view according to the page it should show
    var isSummaryPage : Bool
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
        for i in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel(i + 1, preference_item.operation, preference_item.difficulty))
        }
        isSummaryPage = false
        current = 0
    }
    
    mutating func resetProblemSet(){
        problemSet = [MultiplicationProblemModel]()
        QuestionRounds = preference_item.QuestionRounds
        for i in(0..<QuestionRounds) {
            problemSet.append(MultiplicationProblemModel(i + 1, preference_item.operation, preference_item.difficulty))
        }
        current = 0
        currentPhase = 1
        isSummaryPage = false
    }
    
    mutating func getNextProblem(){
        if current == QuestionRounds - 1 && currentProblem.correctness != .pending{
            isSummaryPage.toggle()
        }
        current = (current + 1) % QuestionRounds        //Calculate the problem number only when we are trying to get the next problem
    }
    
    
    mutating func checkCorrectness(_ Answer: Int){
        if Answer == currentProblem.result{
            problemSet[current].correctness = .correct
        }else{
            problemSet[current].correctness = .wrong
        }
    }
}
