//
//  StartViewController.swift
//  Quiz
//
//  Created by Pascal Hurni on 21.03.17.
//  Copyright © 2017 Pascal Hurni. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var lblBestPlayer: UILabel!
    @IBOutlet var tfUsername: UITextField!
    
    private var scoreBoard: ScoreBoard!
    var session: QuizSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreBoard = ScoreBoard.getInstance()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        // Updates the view controller interface using the updated model
        if session != nil {
            showScore()
        }
        
        if(scoreBoard.username == nil){
            lblBestPlayer.text = "Meilleur : Aucun"
        }
        else{
            lblBestPlayer.text = "Meilleur : \(scoreBoard.username!) avec \(scoreBoard.score!) pts"
        }
    }

    @IBAction func rookieSessionClick(_ sender: AnyObject) {
        session = RookieQuizSession(questionRepository: makeQuestionRepository())
        showSessionView(session!)
    }

    @IBAction func journeymanSessionClick(_ sender: AnyObject) {
        session = JourneymanQuizSession(questionRepository: makeQuestionRepository())
        showSessionView(session!)
    }
    
    @IBAction func masterSessionClick(_ sender: AnyObject) {
        session = MasterQuizSession(questionRepository: makeQuestionRepository())
        showSessionView(session!)
    }
    
    @IBAction func warriorSessionClick(_ sender: AnyObject) {
        session = WarriorQuizSession(questionRepository: makeQuestionRepository())
        showSessionView(session!)
    }
    
    @IBAction func ninjaSessionClick(_ sender: AnyObject) {
        session = NinjaQuizSession(questionRepository: makeQuestionRepository())
        showSessionView(session!)
    }
    
    func makeQuestionRepository() -> QuestionRepository {
        //return RemoteQuestionRepository(remoteUrl: "http://localhost:4567")
        return StaticQuestionRepository()
    }
    
    func showSessionView(_ session: QuizSession)
    {
        let sessionViewController = storyboard?.instantiateViewController(withIdentifier: "sessionVC") as! ViewController
        
        sessionViewController.session = session
        session.username = tfUsername.text
        
        present(sessionViewController, animated: true, completion: nil)
    }

    func showScore() {
        scoreLabel.text = "GAME OVER\nvotre score: \(session!.score) / \(session!.questionsCount)"
    }
    
}
