//
//  ViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 09.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let winningCombos = [["a1", "b1", "c1"],
                         ["a2", "b2", "c2"],
                         ["a3", "b3", "c3"],
                         ["a1", "a2", "a3"],
                         ["b1", "b2", "b3"],
                         ["c1", "c2", "c3"],
                         ["a1", "b2", "c3"],
                         ["a3", "b2", "c1"]]
    
    lazy var allButtons = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    var currentPlayer = "circle"
    var winner: String?
    var xPlayerClaimed: Set = ["", ""]
    var oPlayerClaimed: Set = ["", ""]
    var oPlayerScore = 0
    var xPlayerScore = 0
    
    @IBOutlet weak var a1: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerWinsLabel.textColor = .clear
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        resetGame()
    }
    
    @IBAction func fieldButtonPressed(_ sender: UIButton) {
        if sender.currentImage == nil {
            sender.setImage(UIImage(systemName: currentPlayer), for: .normal)
            if currentPlayer == "circle" {
                oPlayerClaimed.insert(sender.accessibilityLabel ?? "")
                checkWinner()
                currentPlayer = "xmark"
            } else if currentPlayer == "xmark" {
                xPlayerClaimed.insert(sender.accessibilityLabel ?? "")
                checkWinner()
                currentPlayer = "circle"
            }
        }
    }
    
    func resetGame() {
        enableButtons(set: true)
        playerWinsLabel.textColor = .clear
        oPlayerClaimed.removeAll()
        xPlayerClaimed.removeAll()
        currentPlayer = "circle"
        winner = nil
        
        for button in allButtons {
            button!.configuration?.image = nil
            button!.setImage(nil, for: .normal)
        }
    }

    func checkWinner() {
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
        } else if a1.currentImage != nil && a2.currentImage != nil && a3.currentImage != nil && b1.currentImage != nil && b2.currentImage != nil && b3.currentImage != nil && c1.currentImage != nil && c2.currentImage != nil && c3.currentImage != nil && winner == nil {
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
            enableButtons(set: false)
        }
    }
    
    func enableButtons(set buttonStatus: Bool) {
        for button in allButtons {
            button!.isEnabled = buttonStatus
        }
    }
}

