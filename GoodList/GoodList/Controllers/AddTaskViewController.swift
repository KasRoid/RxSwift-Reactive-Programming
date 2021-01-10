//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Kas Song on 1/10/21.
//

import UIKit

class AddTaskViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    // MARK: - Lifecycle;
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Selectors
    @IBAction func save() {
        guard let title = self.taskTitleTextField.text,
              let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex) else { return }
        
        let task = Task(title: title, priority: priority)
    }
}
