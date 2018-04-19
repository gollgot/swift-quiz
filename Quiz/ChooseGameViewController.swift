//
//  ChooseGameViewController.swift
//  Quiz
//
//  Created by cpnv on 05.03.18.
//  Copyright © 2018 Pascal Hurni. All rights reserved.
//

import UIKit

class ChooseGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var pickerChooseGame: UIPickerView!
    @IBOutlet weak var lblGameOver: UILabel!
    
    private var _gameOverMessage: String?
    private var firstTimeViewAppear: Bool?
    private var pickerData: [String] = [String]()
    private var selectedItem: Int!
    
    var gameOverMessage: String! {
        get { return _gameOverMessage! }
        set(value) {_gameOverMessage = value }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerChooseGame.delegate = self
        self.pickerChooseGame.dataSource = self
        
        firstTimeViewAppear = true
        lblGameOver.isHidden = true
        selectedItem = 0 // First item is default selected

        // Do any additional setup after loading the view.
        pickerData = ["Rookie", "Journeyman", "Warrior", "Ninja"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // In the viewCycle, just after the viewDidLoad, the method ViewWillAppear is called
        // So, we want to display the gameover after the first call of the ViewWillAppear
        if(firstTimeViewAppear!){
            firstTimeViewAppear = false
        }else{
            lblGameOver.text = _gameOverMessage!
            lblGameOver.isHidden = false
        }
    }
    
    @IBAction func btnPlayTouchUpInside(_ sender: UIButton) {
        let gameController = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! ViewController
        gameController.chooseGameViewController = self
        gameController.session = QuizSessionFactory.create(sessionType: pickerData[selectedItem], questionRepository: RemoteQuestionRepository(remoteUrl: "http://localhost:4567"))
        self.present(gameController, animated: true, completion: nil)
    }
    
    /************************ PICKER's methods **************************/
    
    // The number of columns of data
    func numberOfComponents(in pickerChooseGame: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
    
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedItem = row
    }
    


}
