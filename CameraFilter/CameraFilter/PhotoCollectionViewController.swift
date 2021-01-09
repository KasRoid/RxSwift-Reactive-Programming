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
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
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

extension PhotoCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        let asset = images[indexPath.item]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 100, height: 100),
                             contentMode: .aspectFit,
                             options: nil,
                             resultHandler: {image, _ in
                                DispatchQueue.main.async {
                                    cell.photoImageView.image = image
                                }
                             })
        return cell
    }
}
