//
//  FilteredImagesViewController.swift
//  ios-image-filtering
//
//  Created by Николай on 12.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

class FilteredImagesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredImages: [(image: UIImage, filterName: String)]!
    
    private let collectionViewItemsPerRow: CGFloat = 3
    private let collectionCellMargin: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("Did receive memory warning")
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.reloadData()
    }
    
    //MARK: - collection view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let targetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "filteredImageCell", for: indexPath) as! FilteredImgeCell
        targetCell.imageView.image = filteredImages[indexPath.row].image
        return targetCell
    }
    
    //MARK: - collection view delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        NSLog("Size for item")
        let width = (collectionView.bounds.width - collectionCellMargin * (collectionViewItemsPerRow + 1)) / collectionViewItemsPerRow - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        NSLog("inset for section")
        return UIEdgeInsets(top: collectionCellMargin,
                            left: collectionCellMargin,
                            bottom: collectionCellMargin,
                            right: collectionCellMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        NSLog("line spacing for section")
        return collectionCellMargin
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
