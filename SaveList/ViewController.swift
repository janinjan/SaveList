//
//  ViewController.swift
//  SaveList
//
//  Created by Janin Culhaoglu on 26/03/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var tasksList = Task.fetchAll()
    var enteredTask = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextField.delegate = self
        addButton.layer.cornerRadius = 4
        taskTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 10)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addNewTask()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        deleteAllTask()
    }
    
    private func addNewTask() {
        self.enteredTask = taskTextField.text!.capitalizingFirstLetter()
        saveTask(named: self.enteredTask)
        self.tasksList = Task.fetchAll()
        tableView.reloadData()
        taskTextField.text = ""
    }
    
    private func saveTask(named name: String) {
        let task = Task(context: AppDelegate.viewContext)
        task.taskName = name
        try? AppDelegate.viewContext.save()
    }
    
    private func deleteAllTask() {
        Task.deleteAll()
        tasksList = Task.fetchAll()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        cell.textLabel?.text = "- " + tasksList[indexPath.row].taskName!
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextField.resignFirstResponder()
        addNewTask()
        return true
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
