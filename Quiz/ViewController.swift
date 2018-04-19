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
    @IBOutlet var timerLabel: UILabel!
    
    private var _chooseGameViewController: ChooseGameViewController!
    private var _session : QuizSession!
    fileprivate var timer: Timer!
    fileprivate var remainingTime :Int!
    fileprivate var remainingQuestionTime :Int!
    
    var chooseGameViewController: ChooseGameViewController! {
        get { return _chooseGameViewController }
        set(value) {_chooseGameViewController = value }
    }
    var session: QuizSession! {
        get { return _session }
        set(value) {_session = value }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create our game session, and get the first question
        //session = NinjaQuizSession(questionRepository: RemoteQuestionRepository(remoteUrl: "http://localhost:4567"))
        nextOne()
        timer = Timer()
        remainingTime = session.remainingTime
        remainingQuestionTime = session.remainingTimePerQuestion
        timerLabel.text = ""
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerClick(_ sender: UIButton) {
        // Tell the session the chosen answer
        session.checkAnswer(sender.currentTitle!)
        
        // Pass to the next question
        nextOne()
    }

    func nextOne() {
        hintLabel.isHidden = true
        hintButton.isHidden = false

        // get the next question from the session
        if let question = session.nextQuestion() {
            // Set the captions
            questionLabel.text = question.caption
            hintLabel.text = question.hint
            answerButton1.setTitle(question.answers[0], for: UIControlState())
            answerButton2.setTitle(question.answers[1], for: UIControlState())
            answerButton3.setTitle(question.answers[2], for: UIControlState())
            
            // Reset the time per question
            remainingQuestionTime = session.remainingTimePerQuestion
        }
        else {
            gameOver()
        }
    }
    
    @IBAction func hintClick(_ sender: UIButton) {
        hintLabel.isHidden = false
        hintButton.isHidden = true
    }
    
    func gameOver() {
        // No more questions! This is the end
        timer.invalidate()

        _chooseGameViewController.gameOverMessage = "GAME OVER\nyour score: \(session.score) / \(session.questionsCount)"
        self.dismiss(animated: true, completion: nil)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,      selector: #selector(updateTimer), userInfo: nil, repeats: true)
        updateTimerLabel(remainingTime)
    }
    
    @objc func updateTimer() {
        // Time per question
        if(remainingQuestionTime != 0+1){ // 0 + 1 to stop exactly at 0
            remainingQuestionTime! -= 1
        }else{
            if(session.needTimerPerQuestion()){
                nextOne()
            }
        }
        
        // Global time
        if remainingTime != 0+1{ // 0 + 1 to stop exactly at 0
            remainingTime! -= 1
            updateTimerLabel(remainingTime)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        updateTimerLabel(0)
        if(session.needTimer()){
            gameOver()
        }
    }
    
    func updateTimerLabel(_ time : Int) {
        if(session.needTimer()){
            timerLabel.text = String(time)
        }
    }
    
}

