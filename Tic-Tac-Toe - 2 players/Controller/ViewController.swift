//
//  ViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 09.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
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
    @IBOutlet weak var oPlayerNameLabel: UILabel!
    @IBOutlet weak var xPlayerNameLabel: UILabel!
    
    @IBOutlet weak var playerWinsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerWinsLabel.textColor = .clear
        gameBrain.addObserver(self, forKeyPath: "winner", options: .new, context: nil)
        gameBrain.addObserver(self, forKeyPath: "oPlayerScore", options: .new, context: nil)
        gameBrain.addObserver(self, forKeyPath: "xPlayerScore", options: .new, context: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameBrain.oPlayerScore = defaults.integer(forKey: "oPlayerScore")
        gameBrain.xPlayerScore = defaults.integer(forKey: "xPlayerScore")
        
        gameBrain.oPlayerName = defaults.string(forKey: "oPlayerName") ?? "oPlayerName"
        gameBrain.xPlayerName = defaults.string(forKey: "xPlayerName") ?? "xPlayerName"
        oPlayerNameLabel.text = "\(gameBrain.oPlayerName) - Score:"
        xPlayerNameLabel.text = "\(gameBrain.xPlayerName) - Score:"
    }
    
    @IBAction func resetGamePressed(_ sender: UIBarButtonItem) {
        gameBrain.resetGame()
        resetGameUI()
    }
    
    @IBAction func fieldButtonPressed(_ sender: UIButton) {
        if let chosenField = sender.accessibilityLabel {
            if sender.currentImage == nil {
                sender.setImage(UIImage(systemName: gameBrain.currentPlayer), for: .normal)
                gameBrain.claimField(with: chosenField)
            }
        } else {
            fatalError("fieldButtonPressed without sending its accessibilityLabel")
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
    
    // MARK: - observer that updates UI whenever gameBrain.winner changes from none:
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "winner" || keyPath == "oPlayerScore" || keyPath == "xPlayerScore" {
            
            oPlayerScoreLabel.text = String(gameBrain.oPlayerScore)
            xPlayerScoreLabel.text = String(gameBrain.xPlayerScore)
            
            if let winner = change?[.newKey] as? String {
                if winner != "none" {
                    if winner == constants.xmark {
                        playerWinsLabel.text = "x Player Wins!"
                    } else if winner == constants.circle {
                        playerWinsLabel.text = "o Player Wins!"
                    } else if winner == constants.draw {
                        playerWinsLabel.text = "It's a draw!"
                    }
                    playerWinsLabel.textColor = .systemBlue
                    enableButtons(set: false)
                }
            }
        }
    }
}

