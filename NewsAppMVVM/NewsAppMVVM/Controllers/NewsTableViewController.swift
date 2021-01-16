//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Kas Song on 1/16/21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
