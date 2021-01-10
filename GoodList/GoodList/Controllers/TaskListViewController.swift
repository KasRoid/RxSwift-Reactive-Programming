//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Kas Song on 1/10/21.
//

import UIKit
import RxSwift

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var tasks = Variable<[Task]>([])
    
    // MARK: - Lifecycle;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let naviVC = segue.destination as? UINavigationController,
              let destVC = naviVC.viewControllers.first as? AddTaskViewController else { return }
        destVC.taskSubjectObservable
            .subscribe(onNext: {
                self.tasks.value.append($0)
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
    
}
