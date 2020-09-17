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
    // Model data
    var QuestionRounds : Int
    var current : Int
    var isRedirectingToSummaryPage : Bool
    var problemSet : [ArthimeticProblemModel]

    var exercisePreferenceSetting : PreferenceModel = PreferenceModel(){
        didSet{
            resetProblemSet()
        }
    }
    
    var exerciseViewState : ExerciseViewState {
        if isRedirectingToSummaryPage{
            return .summary
        }else{
            if currentProblem.correctness == .pending{
                return .question
            }else{
                return .result
            }
        }
    }
    
    
    // Helper variables for Views
    var problemSetOperation : String {exercisePreferenceSetting.operation.rawValue}
    var problemSetDifficulty : String {exercisePreferenceSetting.difficulty.rawValue}
    var currentProblem : ArthimeticProblemModel {problemSet[current]}
    var currentQuestionNumber : Int {currentProblem.id}
    var currentFirstVariable : String {String(currentProblem.firstVariable)}
    var currentSecondVariable : String {String(currentProblem.secondVariable)}
    var currentProblemSelections : [Int] {currentProblem.selection}
    var currentExerciseOperator : String {return exercisePreferenceSetting.operation == .addition ? "+" : "X"}
    
    var correctCount: Int {scoreList.count(for: "✔️")}
    var currentCorrectness: String {String(describing: currentProblem.correctness)}
    var scoreList : [String]{problemSet.map{$0.computeCorrectness()}}
    
    var currentProblemAnalysis: String {"The correct answer is :" + String(currentProblem.result)}
    
    
    init() {
        problemSet = [ArthimeticProblemModel]()
        QuestionRounds = exercisePreferenceSetting.QuestionRounds
        for i in(0..<QuestionRounds) {
            problemSet.append(ArthimeticProblemModel(i + 1, exercisePreferenceSetting.operation, exercisePreferenceSetting.difficulty))
        }
        isRedirectingToSummaryPage = false
        current = 0
    }
    
    // Reset the problem set for another round
    mutating func resetProblemSet(){
        problemSet = [ArthimeticProblemModel]()
        QuestionRounds = exercisePreferenceSetting.QuestionRounds
        for i in(0..<QuestionRounds) {
            problemSet.append(ArthimeticProblemModel(i + 1, exercisePreferenceSetting.operation, exercisePreferenceSetting.difficulty))
        }
        isRedirectingToSummaryPage = false
        current = 0
    }
    
    mutating func getNextProblem(){
        if current == QuestionRounds - 1 && currentProblem.correctness != .pending{
            isRedirectingToSummaryPage.toggle()
        }
        current = (current + 1) % QuestionRounds
    }
    
    
    mutating func checkCorrectness(_ Answer: Int){
        if Answer == currentProblem.result{
            problemSet[current].correctness = .correct
        }else{
            problemSet[current].correctness = .wrong
        }
    }
}
