//
//  ViewController.swift
//  Hello-RxSwift
//
//  Created by Kas Song on 1/3/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Observable.from([1, 2, 3, 4, 5])
    }
}

