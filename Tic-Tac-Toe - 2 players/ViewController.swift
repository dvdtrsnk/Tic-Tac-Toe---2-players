//
//  ViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 09.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var winningCombos = [["a1", "b1", "c1"],  //model
                         ["a2", "b2", "c2"],
                         ["a3", "b3", "c3"],
                         ["a1", "a2", "a3"],
                         ["b1", "b2", "b3"],
                         ["c1", "c2", "c3"],
                         ["a1", "b2", "c3"],
                         ["a3", "b2", "c1"]   ]
    
    
    var currentPlayer = "circle" // model
    var winner: String?          // model
    var xPlayerClaimed: Set = ["", ""]
    var oPlayerClaimed: Set = ["", ""]
    var oPlayerScore = 0
    var xPlayerScore = 0
    
    
    @IBOutlet weak var a1: UIButton! //Controller
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var oPlayerScoreLabel: UILabel!
    @IBOutlet weak var xPlayerScoreLabel: UILabel!
    @IBOutlet weak var playerWinsLabel: UILabel!
    
    
    override func viewDidLoad() { //Controller
        super.viewDidLoad()
        playerWinsLabel.textColor = .clear
    }
    
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) { //Controller
        resetGame()
    }
    
    @IBAction func fieldButtonPressed(_ sender: UIButton) { //Controller
        if sender.currentImage == nil {
            sender.setImage(UIImage(systemName: currentPlayer), for: .normal)
            if currentPlayer == "circle" {
                oPlayerClaimed.insert(sender.accessibilityLabel ?? "") //Model
                checkWinner()
                
                currentPlayer = "xmark" // Model
                
            } else if currentPlayer == "xmark" {
                xPlayerClaimed.insert(sender.accessibilityLabel ?? "") //Model
                checkWinner()
                currentPlayer = "circle" // Model
            }
        }
        
        
        func checkWinner() { // Model
            if currentPlayer == "circle" {
                for x in 0...7 {
                    if oPlayerClaimed.isSuperset(of: winningCombos[x]) {
                        winner = "circle"
                    }
                }
            } else if currentPlayer == "xmark" {
                for x in 0...7 {
                    if xPlayerClaimed.isSuperset(of: winningCombos[x]) {
                        winner = "xmark"
                    }
                }
            }
            
            if a1.currentImage != nil && a2.currentImage != nil && a3.currentImage != nil && b1.currentImage != nil && b2.currentImage != nil && b3.currentImage != nil && c1.currentImage != nil && c2.currentImage != nil && c3.currentImage != nil && winner == nil {
                winner = "draw"
            }
            
            
            if winner != nil {
                if winner == "xmark" {
                    playerWinsLabel.text = "x Player Wins!"
                    xPlayerScore += 1
                } else if winner == "circle" {
                    playerWinsLabel.text = "o Player Wins!"
                    oPlayerScore += 1
                } else if winner == "draw" {
                    playerWinsLabel.text = "It's a draw!"
                }
                oPlayerScoreLabel.text = String(oPlayerScore)
                xPlayerScoreLabel.text = String(xPlayerScore)
                playerWinsLabel.textColor = .systemBlue
                
                enableButtons(false)


            }
            
        }
        
    }
    func resetGame() { // Model
        enableButtons(true)
        
        playerWinsLabel.textColor = .clear
        currentPlayer = "circle"
        winner = nil
        oPlayerClaimed.removeAll()
        xPlayerClaimed.removeAll()
        
        print("resetGame pressed")

        a1.configuration?.image = nil
        a1.setImage(nil, for: .normal)
        a2.configuration?.image = nil
        a2.setImage(nil, for: .normal)
        a3.configuration?.image = nil
        a3.setImage(nil, for: .normal)
        b1.configuration?.image = nil
        b1.setImage(nil, for: .normal)
        b2.configuration?.image = nil
        b2.setImage(nil, for: .normal)
        b3.configuration?.image = nil
        b3.setImage(nil, for: .normal)
        c1.configuration?.image = nil
        c1.setImage(nil, for: .normal)
        c2.configuration?.image = nil
        c2.setImage(nil, for: .normal)
        c3.configuration?.image = nil
        c3.setImage(nil, for: .normal)

    }
    
    func enableButtons(_ buttonStatus: Bool) { // Model
        a1.isEnabled = buttonStatus
        a2.isEnabled = buttonStatus
        a3.isEnabled = buttonStatus
        b1.isEnabled = buttonStatus
        b2.isEnabled = buttonStatus
        b3.isEnabled = buttonStatus
        c1.isEnabled = buttonStatus
        c2.isEnabled = buttonStatus
        c3.isEnabled = buttonStatus
    }
    
}

