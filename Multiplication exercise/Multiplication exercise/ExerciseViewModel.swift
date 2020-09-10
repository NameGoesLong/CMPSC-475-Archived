//
//  ExerciseViewModel.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation


class ExerciseViewModel: ObservableObject {
    @Published var exerciseModel = ExerciseModel()
    
    var multiplicand : String {String(exerciseModel.currentProblem.multiplicand)}
    var multiplier : String {String(exerciseModel.currentProblem.multiplier)}
    var selection : [Int] {exerciseModel.currentProblem.selection}
    var currentPage: Bool {exerciseModel.isQuestPage}
    var currentQuestionNumber : Int {exerciseModel.current + 1}
    var resultButtonText : String {exerciseModel.resultButtonText}
    var currentCorrectness: String {String(describing: exerciseModel.currentProblem.correctness)}
    var totalCorrectness: Int {exerciseModel.correctness}
    var analysis : String {exerciseModel.analysis}
    var isSummaryPage : Bool {exerciseModel.isSummaryPage}
    
    var ScoreList : [String]{exerciseModel.problemSet.map{$0.computeCorrectness()}}
    
    
    
    func nextProblem(){
        exerciseModel.getNextProblem()
    }
    
    func getSelectedAnswer(_ Answer: Int){
        exerciseModel.checkCorrectness(Answer)
    }
}
