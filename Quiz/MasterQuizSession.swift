//
//  MasterQuizSession.swift
//  Quiz
//
//  Created by cpnv on 16.04.18.
//  Copyright © 2018 Pascal Hurni. All rights reserved.
//

import Foundation

class MasterQuizSession : QuizSession {
    var _currentQuestionCount: Int
    
    override init(questionRepository: QuestionRepository, totalQuestionCount: Int = 5) {
        _currentQuestionCount = 0
        super.init(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount)
    }
    
    override func nextQuestion() -> Question? {
        _currentQuestionCount += 1
        if _currentQuestionCount > _totalQuestionCount {
            return nil
        }
        
        return super.nextQuestion()
    }
    
    override func checkAnswer(_ answer: String) -> Bool {
        let correct = super.checkAnswer(answer)
        _score += correct ? 2 : -5
        return true // return true even if the answer is incorrect to pass to the next question
    }
    
}
