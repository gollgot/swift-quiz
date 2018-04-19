//
//  ScoreBoard.swift
//  Quiz
//
//  Created by cpnv on 16.04.18.
//  Copyright © 2018 Pascal Hurni. All rights reserved.
//

import Foundation


// This is a Singleton class that can be load to get the actual scoreBoard
class ScoreBoard {
    
    static var scoreBoard: ScoreBoard? = nil
    
    private var _username : String?
    var username: String? {
        get { return _username}
        set(value) {_username = value }
    }
    private var _score : Int?
    var score: Int? {
        get { return _score}
        set(value) {_score = value }
    }
    
    private init() {}
    
    static func getInstance() -> ScoreBoard{
        if (scoreBoard == nil){
            scoreBoard = ScoreBoard()
        }
        return scoreBoard!
    }
    
}
