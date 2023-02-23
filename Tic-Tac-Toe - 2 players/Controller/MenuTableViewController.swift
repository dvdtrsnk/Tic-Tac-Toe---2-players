//
//  SettingsTableViewController.swift
//  Tic-Tac-Toe - 2 players
//
//  Created by David Třešňák on 22.02.2023.
//


import UIKit


class MenuViewController: UITableViewController {
    
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
            changeUserNameAlert()
        case 1:
            resetScore()
        case 2:
            showHelp()
        default:
            break
        }
    }
    
    
    // MARK: - Functions
    private func changeUserNameAlert() {
        let alert = UIAlertController(title: "Change User Names", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "oPlayer User Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "xPlayer User Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let textField = alert.textFields?.first, let newName = textField.text, !newName.isEmpty else {
                return
            }
            // Implement user name change logic
            print("New user name: \(newName)")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showHelp() {
        let alert = UIAlertController(title: "Help", message: "This is game helper", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        alert.addAction(doneAction)
        print("Help")
        present(alert, animated: true, completion: nil)
    }
    
     func resetScore() {
        navigationController?.popToRootViewController(animated: true)
    }
}
