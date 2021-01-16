//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Kas Song on 1/16/21.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    private func populateNews() {
        let url = URL(string: "")!
        let resource = Resource<ArticleResponse>(url: url)
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
    }
}
