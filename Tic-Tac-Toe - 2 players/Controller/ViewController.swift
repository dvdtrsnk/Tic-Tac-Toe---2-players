//
//  ViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 09.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let gameBrain = GameBrain()
    lazy var allButtons = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    
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
        gameBrain.addObserver(self, forKeyPath: "winner", options: .new, context: nil)
    }
    
    @IBAction func resetGamePressed(_ sender: UIBarButtonItem) {
        gameBrain.resetGame()
        resetGameUI()
    }
    
    @IBAction func fieldButtonPressed(_ sender: UIButton) {
        // Controller zkontroluje že pole není obsazené
        // Není obsazený = když je aktuální hráč O tak:
        // přidá hráči pole do jeho Claimed
        // spustí checkwinner
        // změní aktuálního hráče na X
        
        //Controller
        
        
        if sender.currentImage == nil { //MODEL
            sender.setImage(UIImage(systemName: gameBrain.currentPlayer), for: .normal)
            if gameBrain.currentPlayer == constants.circle {
                gameBrain.oPlayerClaimed.insert(sender.accessibilityLabel ?? "")
                gameBrain.checkWinner()
                gameBrain.currentPlayer = constants.xmark //MODEL
                
                
            } else if gameBrain.currentPlayer == constants.xmark { //MODEL
                gameBrain.xPlayerClaimed.insert(sender.accessibilityLabel ?? "")
                gameBrain.checkWinner()
                gameBrain.currentPlayer = constants.circle //MODEL
            }
        }
    }
    
    func resetGameUI() {
        enableButtons(set: true)
        playerWinsLabel.textColor = .clear
        for button in allButtons {
            button!.configuration?.image = nil
            button!.setImage(nil, for: .normal)
        }
    }
    
    func enableButtons(set buttonStatus: Bool) {
        for button in allButtons {
            button!.isEnabled = buttonStatus
        }
    }
    
    //MARK: observer that updates UI whenever gameBrain.winner changes from none:
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "winner" {
            if let winner = change?[.newKey] as? String {
                playerWinsLabel.text = winner
                playerWinsLabel.textColor = .blue
                if winner != "none" {
                    if winner == constants.xmark {
                        playerWinsLabel.text = "x Player Wins!"
                    } else if winner == constants.circle {
                        playerWinsLabel.text = "o Player Wins!"
                    } else if winner == constants.draw {
                        playerWinsLabel.text = "It's a draw!"
                    }
                    oPlayerScoreLabel.text = String(gameBrain.oPlayerScore)
                    xPlayerScoreLabel.text = String(gameBrain.xPlayerScore)
                    playerWinsLabel.textColor = .systemBlue
                    enableButtons(set: false)
                }
            }
        }
    }
    
}

