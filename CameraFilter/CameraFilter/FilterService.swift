//
//  FilterService.swift
//  CameraFilter
//
//  Created by Kas Song on 1/9/21.
//

import UIKit
import CoreImage

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
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
