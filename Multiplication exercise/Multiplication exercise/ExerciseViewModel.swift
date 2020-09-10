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
    
    var currentPage: Bool {exerciseModel.isQuestPage}       //be used to manage the opacity of QuestView and Result View
    
    //The following are used in QuestView
    var currentQuestionNumber : Int {exerciseModel.current + 1}     // Notice the current in exercise model is starting at 0
    var multiplicand : String {String(exerciseModel.currentProblem.multiplicand)}
    var multiplier : String {String(exerciseModel.currentProblem.multiplier)}
    var selection : [Int] {exerciseModel.currentProblem.selection}
    
    //The following are used in ScoreView
    var totalCorrectness: Int {exerciseModel.correctness}
    var ScoreList : [String]{exerciseModel.problemSet.map{$0.computeCorrectness()}}
    
    //The following are used in ResultView
    var currentCorrectness: String {String(describing: exerciseModel.currentProblem.correctness)}
    var resultButtonText : String {exerciseModel.resultButtonText}
    var analysis : String {exerciseModel.analysis}
    var isSummaryPage : Bool {exerciseModel.isSummaryPage}
    
    
    // Called by the button in the ResultView to get the next problem
    func nextProblem(){
        exerciseModel.getNextProblem()
    }
    
    // Called by the buttion in the ChoiceView to pass in the user selection
    func getSelectedAnswer(_ Answer: Int){
        exerciseModel.checkCorrectness(Answer)
    }
}
