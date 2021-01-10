//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Kas Song on 1/10/21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
