//
//  QuizSession.swift
//  Quiz
//
//  Created by Pascal Hurni on 17.02.16.
//  Copyright (c) 2016 Pascal Hurni. All rights reserved.
//

import Foundation

class QuizSession {
    // Because swift has no `protected` access control, we fall back
    // on internal with an ugly underscore prefix, so that code with
    // an explicit receiver looks ugly and should be prevented.
    // (see https://medium.com/ios-os-x-development/swift-needs-protected-access-level-b966001a1d08 )
    
    let _questionRepository: QuestionRepository
    var _currentQuestion: Question!
    var _totalQuestionCount: Int
    var _score = 0
    var _remainingTime: Int = 45 // This is the default remaining time, if you want to set another one, change this value in your child xyQuizSession
    var _remainingTimePerQuestion: Int = 10 // This is the default remaining time per question, if you want to set another one, change this value in your child xyQuizSession
    
    // Public interface to get the score, as a property
    var score: Int {
        get { return _score }
    }

    // Public interface to get the total question count
    var questionsCount: Int {
        get { return _totalQuestionCount }
    }
    // Public interface to get the total question count
    var remainingTime: Int {
        get { return _remainingTime }
        set(value) {_remainingTime = value }
    }
    
    // Public interface to get the total question count
    var remainingTimePerQuestion: Int {
        get { return _remainingTimePerQuestion }
        set(value) {_remainingTimePerQuestion = value }
    }

    init(questionRepository: QuestionRepository, totalQuestionCount: Int) {
        _questionRepository = questionRepository
        _totalQuestionCount = totalQuestionCount
    }
    
    func nextQuestion() -> Question? {
        _currentQuestion = _questionRepository.fetchQuestion()
        return _currentQuestion
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        return _currentQuestion.isCorrectAnswer(answer)
    }
    
    func needTimer() -> Bool {
        return false
    }
    
    func needTimerPerQuestion() -> Bool {
        return false
    }
    
}
