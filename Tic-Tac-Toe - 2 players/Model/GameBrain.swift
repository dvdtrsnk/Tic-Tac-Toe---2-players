//
//  GameBrain.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 22.02.2023.
//

import UIKit

class GameBrain: UIViewController {
    
    let allFields = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
    let winningFieldCombos = [["a1", "b1", "c1"],
                              ["a2", "b2", "c2"],
                              ["a3", "b3", "c3"],
                              ["a1", "a2", "a3"],
                              ["b1", "b2", "b3"],
                              ["c1", "c2", "c3"],
                              ["a1", "b2", "c3"],
                              ["a3", "b2", "c1"]]
    var xPlayerClaimed: Set = ["", ""]
    var oPlayerClaimed: Set = ["", ""]
    var currentPlayer = constants.circle
    @objc dynamic var winner = "none"
    var oPlayerScore = 0
    var xPlayerScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func resetGame() {
        oPlayerClaimed.removeAll()
        xPlayerClaimed.removeAll()
        currentPlayer = constants.circle
        winner = "none"
    }
    
    func checkWinner() {
        let claimedFields: Set = xPlayerClaimed.union(oPlayerClaimed)
        if claimedFields.isSuperset(of: allFields) && winner == "none" {
            winner = constants.draw
        } else if currentPlayer == constants.circle {
            for x in 0...7 {
                if oPlayerClaimed.isSuperset(of: winningFieldCombos[x]) {
                    oPlayerScore += 1
                    winner = constants.circle
                }
            }
        } else if currentPlayer == constants.xmark {
            for x in 0...7 {
                if xPlayerClaimed.isSuperset(of: winningFieldCombos[x]) {
                    xPlayerScore += 1
                    winner = constants.xmark
                }
            }
        }
    }
}
