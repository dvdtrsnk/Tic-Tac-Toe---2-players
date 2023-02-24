//
//  SettingsTableViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 22.02.2023.
//


import UIKit

protocol MenuTableViewControllerDelegate: AnyObject {
    func resetPlayerScore()
}

class MenuTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    weak var delegate: MenuTableViewControllerDelegate?
    private let gameBrain = GameBrain()
    private let menuItems = ["Change User Names", "Reset Players Score", "Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableView Data Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    // MARK: - TableView Data Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            changeUserNames()
        case 1:
            resetScore()
        case 2:
            showHelp()
        default:
            break
        }
    }
    
    
    // MARK: - Functions
    private func changeUserNames() {
        let alert = UIAlertController(title: "Change User Names", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "oPlayer User Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "xPlayer User Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let oPlayerTextField = alert.textFields?[0], let oPlayerName = oPlayerTextField.text, !oPlayerName.isEmpty else {
                return
            }
            guard let xPlayerTextField = alert.textFields?[1], let xPlayerName = xPlayerTextField.text, !xPlayerName.isEmpty else {
                return
            }
            self.defaults.setValue(oPlayerName, forKey: "oPlayerName")
            self.defaults.setValue(xPlayerName, forKey: "xPlayerName")
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func resetScore() {
        gameBrain.oPlayerScore = 0
        gameBrain.xPlayerScore = 0
        defaults.set(gameBrain.oPlayerScore,forKey: "oPlayerScore")
        defaults.set(gameBrain.xPlayerScore, forKey: "xPlayerScore")
       navigationController?.popToRootViewController(animated: true)
   }
    
    private func showHelp() {
        let alert = UIAlertController(title: "Help", message: "This is simple Tic-Tac-Toe Game for 2 players. In settings you can change Players name or restart their score to 0.", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        alert.addAction(doneAction)
        print("Help")
        present(alert, animated: true, completion: nil)
    }
    

}
