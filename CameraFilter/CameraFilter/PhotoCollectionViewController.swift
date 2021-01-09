//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Kas Song on 1/5/21.
//

import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            switch status {
            case .authorized:
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                print(self?.images.count)
//                self?.collectionView.reloadData()
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
