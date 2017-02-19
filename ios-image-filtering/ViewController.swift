//
//  ViewController.swift
//  ios-image-filtering
//
//  Created by Николай on 12.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import MobileCoreServices
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var imageView: UIImageView!
    var btnOpen: UIBarButtonItem!
    var btnSave: UIBarButtonItem!
    var btnUndo: UIBarButtonItem!
    
    var filteredImages: [(image: UIImage, filterName: String)]!
    private let filterHelper = FilterHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnOpen = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(ViewController.open))
        btnSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ViewController.save))
        btnUndo = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(ViewController.undo))
        
        navigationBar.leftBarButtonItems = [btnOpen]
        
        filteredImages = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilteredImages" {
            let targetVC = segue.destination as! FilteredImagesViewController
            targetVC.filteredImages = filteredImages
        }
    }
    
    func populateFilteredImages() {
        if let image = imageView.image {
            if filteredImages.count > 0 {
                filteredImages.removeAll()
            }
            
            let filteredImage = filterHelper.getFilteredImage(image: image, filterName: .gaussianBlur)!
            imageView.image = filteredImage
            
//            for filterName in FilterName.allValues {
////                filteredImages.append((filterHelper.getFilteredImage(image: image, filterName: filterName)!,
////                                       filterHelper.getPrettyName(filterName: filterName)!))
//                filteredImages.append((filteredImage, "abc"))
//            }
        }
    }

    //MARK: - image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            populateFilteredImages()
            NSLog("New image loaded")
        }
        NSLog("Will dismiss image picker")
        self.dismiss(animated: true, completion: nil)
    }

    
    //MARK: - navigation bar actions
    func open() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func save() {
        
    }
    
    func undo() {
        
    }
}

