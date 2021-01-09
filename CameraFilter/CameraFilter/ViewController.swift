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
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let naviVC = segue.destination as? UINavigationController,
              let nextVC = naviVC.viewControllers.first as? PhotoCollectionViewController else { fatalError() }
        nextVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    @IBAction func applyFilterButtonPressed(_ sender: UIButton) {
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        FilterService().applyFilter(to: sourceImage,
                                    completion: { [weak self] filteredImage in
                                        DispatchQueue.main.async {
                                            self?.photoImageView.image = filteredImage
                                        }
                                    })
    }
}
