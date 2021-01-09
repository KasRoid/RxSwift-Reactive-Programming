//
//  ViewController.swift
//  CameraFilter
//
//  Created by Kas Song on 1/5/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let naviVC = segue.destination as? UINavigationController,
              let nextVC = naviVC.viewControllers.first as? PhotoCollectionViewController else { fatalError() }
        nextVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
    }
}
