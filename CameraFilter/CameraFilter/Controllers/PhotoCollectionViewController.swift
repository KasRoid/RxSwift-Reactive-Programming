//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Kas Song on 1/5/21.
//

import UIKit
import Photos
import RxSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    private var images = [PHAsset]()
    private let photoManager = PHImageManager.default()
    
    var selectedPhoto: Observable<UIImage> { // 사용자가 가장 최근에 선택한 사진
        return selectedPhotoSubject.asObservable()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
}

// MARK: - Delegate Methods
extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = images[indexPath.item]
        photoManager.requestImage(for: selectedAsset,
                                  targetSize: CGSize(width: 300, height: 300),
                                  contentMode: .aspectFit,
                                  options: nil,
                                  resultHandler: { [weak self] image, info in
                                    guard let info = info else { return }
                                    let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
                                    if !isDegradedImage {
                                        if let image = image {
                                            self?.selectedPhotoSubject.onNext(image) // 새로운 값 전달
                                            self?.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                  })
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        let asset = images[indexPath.item]
        photoManager.requestImage(for: asset,
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

// MARK: - Photo Authorizations
extension PhotoCollectionViewController {
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            switch status {
            case .authorized:
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse() // 사진을 최신순으로 정렬
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
