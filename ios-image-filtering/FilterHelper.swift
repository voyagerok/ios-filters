//
//  FilterHelper.swift
//  ios-image-filtering
//
//  Created by Николай on 15.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit
import CoreImage

enum FilterName: String {
    case gaussianBlur = "CIGaussianBlur"
    case zoomBlur = "CIZoomBlur"
    case toneCurve = "CIToneCurve"
    case colorPosterize = "CIColorPosterize"
    case colorInvert = "CIColorInvert"
    case sepiaTone = "CISepiaTone"
//    case usharpMask = "CIUsharpMask"
    case bloom = "CIBloom"
    case comicEffect = "CIComicEffect"
    case gloom = "CIGloom"
    case crystallize = "CICrystallize"
    case pixellate = "CIPixellate"
    
    static let allValues = [gaussianBlur,
                            .zoomBlur,
                            .toneCurve,
                            .colorPosterize,
                            .colorInvert,
                            .sepiaTone,
//                            .usharpMask,
                            .bloom,
                            .comicEffect,
                            .gloom,
                            .crystallize,
                            .pixellate]
}

class FilterHelper: NSObject {
    
//    private var context: CIContext!
    
    override init() {
//        context = CIContext()
    }
    
    func getPrettyName(filterName: FilterName) -> String? {
        return CIFilter.localizedName(forFilterName: filterName.rawValue)
    }
    
    func getFilteredImage(image: UIImage, filterName: FilterName) -> UIImage? {
        let context = CIContext()
        if let coreImageObj = CIImage(image: image) {
            if let filter = CIFilter(name: filterName.rawValue){
                filter.setValue(coreImageObj, forKey: kCIInputImageKey)
                if filterName == .crystallize || filterName == .pixellate {
                    let center = CIVector(x: image.size.width / 2, y: image.size.height / 2)
                    filter.setValue(center, forKey: kCIInputCenterKey)
                }
                let output = filter.outputImage!
                let cgImage = context.createCGImage(output, from: output.extent)
                let result = UIImage(cgImage: cgImage!)
//                CGImageRelease(cgImage!)
                return result
            }
        }
        
        return nil
    }

}
