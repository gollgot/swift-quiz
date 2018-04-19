//
//  ViewController.swift
//  Quiz
//
//  Created by Pascal Hurni on 17.02.16.
//  Copyright (c) 2016 Pascal Hurni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var hintButton: UIButton!
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var lblCurrentScore: UILabel!
    
    var session : QuizSession!
    var timer: Timer! // For swift3, use Timer!
    private var scoreBoard: ScoreBoard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreBoard = ScoreBoard.getInstance()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sessionTick), userInfo: nil, repeats: true)
        
        nextOne()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sessionTick() {
        if (session.tickAndShouldPassToNextQuestion()) {
            nextOne()
        }
        timeLabel.text = session.timeInfo()
    }

    @IBAction func answerClick(_ sender: UIButton) {
        let isCorrect = session.checkAnswer(sender.currentTitle!)
        lblCurrentScore.text = "Score actuel : \(session.score)"
        // Tell the session the chosen answer
        if (isCorrect) {
            // Pass to the next question
            nextOne()
        }
    }

    func nextOne() {
        hintLabel.isHidden = true
        hintButton.isHidden = false

        // get the next question from the session
        if let question = session.nextQuestion() {
            // Set the captions
            questionLabel.text = question.caption
            hintLabel.text = question.hint
            let randomAnswers = getUniqueRandomNumbers(maxNumber: 3)
            answerButton1.setTitle(question.answers[randomAnswers[0]], for: UIControlState())
            answerButton2.setTitle(question.answers[randomAnswers[1]], for: UIControlState())
            answerButton3.setTitle(question.answers[randomAnswers[2]], for: UIControlState())
        }
        // Game Over
        else {
            updateScoreBoard()
            
            // No more question, game finished
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func hintClick(_ sender: UIButton) {
        hintLabel.isHidden = false
        hintButton.isHidden = true
    }
    
    func updateScoreBoard(){
        // Score board empty
        if(scoreBoard.username == nil){
            scoreBoard.username = session.username
            scoreBoard.score = session.score
        }else{
            // Update scoreBoard only if userSession's score is better than scoreBoard score
            if(session.score > scoreBoard.score!){
                scoreBoard.username = session.username
                scoreBoard.score = session.score
            }
        }
    }
    
    // This method will return an array of int contains only unique number between 0 and maxNumber
    func getUniqueRandomNumbers(maxNumber: Int) -> [Int]{
        var randomNumbers = [Int]()
        
        while(randomNumbers.count < maxNumber){
            let random: Int = Int(arc4random_uniform(UInt32(maxNumber)))
            var found: Bool = false
            
            for arrayNumber in randomNumbers {
                if(arrayNumber == random){
                    found = true
                }
            }
            
            if(!found){
                randomNumbers += [random]
            }
        }
        
        return randomNumbers
    }
    
}

