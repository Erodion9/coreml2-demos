//
//  ViewController.swift
//  Image Analyzer
//
//  Created by Nyisztor, Karoly on 10/14/18.
//  Copyright © 2018 Nyisztor, Karoly. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.stateChangeHandler = { [weak self] change in
            self?.apply(change: change)
        }
    }
    
    // MARK: - Actions
    @IBAction func takePicture() {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true)
    }
    
    private func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Handling Image Picker Selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to supply the original image.
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
        //guard let uiImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Error! Could not retrieve image from image picker.")
        }
        
        imageView.image = uiImage
        viewModel.performVisionRequest(image: uiImage)
    }
}

//MARK: - Vision

extension ViewController {
    
    private func visualizeObservations(observations: [VNDetectedObjectObservation]) {
        guard let image = imageView.image else {
            print("Failed to retrieve image.")
            return
        }
        let imageSize = image.size
        var transform = CGAffineTransform.identity.scaledBy(x: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
        transform = transform.scaledBy(x: imageSize.width, y: imageSize.height)
    }
}

//MARK: - State Change Handling

extension ViewController {
    
    func apply(change: ViewModel.Change) {
        switch change {
        case .observationsComplete(observations: let observations):
            self.visualizeObservations(observations: observations)
        }
    }
}
