//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Kas Song on 1/5/21.
//

import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                break
            case .denied:
                break
            case .limited:
                break
            case .notDetermined:
                break
            case .restricted:
                break
            @unknown default:
                fatalError()
            }
        }
    }
}
