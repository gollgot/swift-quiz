//
//  QuizSessionFactory.swift
//  Quiz
//
//  Created by cpnv on 05.03.18.
//  Copyright © 2018 Pascal Hurni. All rights reserved.
//

import Foundation

class QuizSessionFactory {
    
    static func create(sessionType: String, questionRepository: QuestionRepository)->QuizSession {
        switch sessionType {
            case "Rookie":
                return RookieQuizSession(questionRepository: questionRepository)
            case "Journeyman":
                return JourneymanQuizSession(questionRepository: questionRepository)
            case "Warrior":
                return WarriorQuizSession(questionRepository: questionRepository)
            case "Ninja":
                return NinjaQuizSession(questionRepository: questionRepository)
            default:
                return RookieQuizSession(questionRepository: questionRepository)
        }
    }
    
}
