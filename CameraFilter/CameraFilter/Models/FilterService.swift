//
//  FilterService.swift
//  CameraFilter
//
//  Created by Kas Song on 1/9/21.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {

    // MARK: - Properties
    private var context: CIContext
    
    // MARK: - Lifecycle
    init() {
        self.context = CIContext()
    }
    
    // MARK: - Helpers
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage,
                             completion: { filteredImage in
                                observer.onNext(filteredImage)
                             })
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping (UIImage) -> Void) {
        guard let filter = CIFilter(name: "CICMYKHalftone") else { return }
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        guard let sourceImage = CIImage(image: inputImage) else { return }
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        guard let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) else { return }
        let processedImage = UIImage(cgImage: cgimg,
                                     scale: inputImage.scale,
                                     orientation: inputImage.imageOrientation)
        completion(processedImage)
    }
}
