//
//  NinjaQuizSession.swift
//  Quiz
//
//  Created by cpnv on 01.03.18.
//  Copyright © 2018 Pascal Hurni. All rights reserved.
//

import Foundation

class NinjaQuizSession: QuizSession {
    var _currentQuestionCount: Int
    fileprivate var currentCorrectAnswer: Bool
    
    init(questionRepository: QuestionRepository) {
        _currentQuestionCount = 0
        currentCorrectAnswer = true // First time must be true because the view controller fetch directly a new question when we start a game
        
        super.init(questionRepository: questionRepository, totalQuestionCount: 10)
        remainingTime = 30
        remainingTimePerQuestion = 3
    }
    
    override func needTimer() -> Bool {
        return true
    }
    
    override func needTimerPerQuestion() -> Bool {
        return true
    }
    
    override func nextQuestion() -> Question? {
        if (!currentCorrectAnswer){
            return _currentQuestion
        }else{
            _currentQuestionCount += 1
            if(_currentQuestionCount > _totalQuestionCount){
                return nil
            }
            
            return super.nextQuestion()
        }
    }
    
    override func checkAnswer(_ answer: String) -> Bool {
        let correct = super.checkAnswer(answer)
        if(correct){
            _score += 1
            currentCorrectAnswer = true
        }else{
            _score -= 1
            currentCorrectAnswer = false
        }
        
        return correct
    }
    
    
    
}
