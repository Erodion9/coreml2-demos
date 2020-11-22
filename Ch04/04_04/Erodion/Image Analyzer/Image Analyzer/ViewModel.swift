//
//  ViewModel.swift
//  Image Analyzer
//
//  Created by Deniz Mavi on 22.11.2020.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import UIKit
import Vision

final class ViewModel {

    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                        orientation: image.cgOrientation,
                                                        options: [:])
    }
}
