//
//  ViewController.swift
//  TapGame
//
//  Created by Lauren Kearley on 8/29/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var player1score: Int = 0
    var player2score: Int = 0
    var isGameStarted: Bool = false
    
    //MARK: Properties
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        player1Button.isEnabled = false
        player2Button.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func player2Button(_ sender: UIButton) {
        player2score += 1
        updateUI()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        isGameStarted = true
        player1Button.isEnabled = true
        player2Button.isEnabled = true
        player1score = 0
        player2score = 0
        updateUI()
        
        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false, block: {timer in
            self.player1Button.isEnabled = false
            self.player2Button.isEnabled = false
            var winner:String
            switch self.findWinner(oneScore: self.player1score, twoScore: self.player2score) {
            case 1:
                winner = "Player 1"
            case 2:
                winner = "Player 2"
            default:
                winner = "It's a tie!"
            }
            
            if (winner != "It's a tie!") {
                let gameOverAlert = UIAlertController(title: "Game Over", message: winner + " wins", preferredStyle: UIAlertControllerStyle.alert)
                gameOverAlert.addAction(UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.default, handler: { (action) in
                    self.resetGame()
                    self.isGameStarted = false
                }))
                self.present(gameOverAlert, animated: true, completion: nil)
            } else {
                let gameOverAlert = UIAlertController(title: "Game Over", message: winner, preferredStyle: UIAlertControllerStyle.alert)
                gameOverAlert.addAction(UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.default, handler: { (action) in
                    self.resetGame()
                    self.isGameStarted = false
                }))
                self.present(gameOverAlert, animated: true, completion: nil)
            }
        
        })
        
        
    }
    
    @IBAction func player1Button(_ sender: UIButton) {
        player1score += 1
        updateUI()
    }
    
    //MARK:Functions
    func updateUI() {
        if isGameStarted {
            player1Score.text = "Player 1 Score = \(player1score)"
            player2Score.text = "Player 2 Score = \(player2score)"
        }
    }
    
    func findWinner(oneScore: Int, twoScore: Int) -> Int {
        if (oneScore > twoScore) {
            return 1
        } else if (twoScore > oneScore) {
            return 2
        }
        return 3
    }
    
    func resetGame() {
        self.player1score = 0
        self.player2score = 0
        self.updateUI()
    }

}

