//
//  ARGalleryViewController.swift
//  ARFreeAndForSale
//
//  Created by Janki Patel on 11/6/18.
//  Copyright © 2018 Janki Patel. All rights reserved.
//

import UIKit
import Foundation
import QuickLook

class ARGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource  {

    @IBOutlet var collectionView: UICollectionView!
    
    let models = ["Wheelbarrow", "Watering can", "Teapot", "Gramophone", "Red chair", "Tulip", "Plantpot", "Retro TV", "Sofa", "Office chair","Table", "Brown Dresser", "Desk", "Bed", "Couch", "TV", "TV Table", "iPhone6", "iPhoneX", "Bose Wave Music System IV", "Mirror", "Guitar", "Piano", "Alienware 17", "Apple Watch", "Bin Box", "Bookshelf", "Ciaz", "Corner Table", "Cowboy Boots", "Drawer Storage", "Fitbit Charge2", "Full Bed", "Hanger", "Heels", "iMac 21.5''", "Infinity 48V Bike", "Small Dresser", "Lawn Mover", "Macbook Pro 15'", "Mountain Gear Bike", "Notebooks", "Samsung Monitor", "Sony Alpha100", "Study Lamp", "Trash can", "Wide Dresser", "Carpet", "Sony-ZX Series", "Whiteboard"]
    
    var thumbnails = [UIImage]()
    var thumbnailIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // new back button
        self.navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(ARGalleryViewController.back(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        backBtn.tintColor = UIColor.black
        
        // swipe to go back
        let backSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ARGalleryViewController.back(_:)))
        backSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(backSwipe)
        
        for model in models {
            if let thumbnail = UIImage(named: "\(model).jpg") {
                thumbnails.append(thumbnail)
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as? LibraryCollectionViewCell
        
        if let cell = cell {
            cell.modelThumbnail.image = thumbnails[indexPath.item]
            let title = models[indexPath.item]
            cell.modelTitle.text = title.capitalized
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        thumbnailIndex = indexPath.item
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: models[thumbnailIndex], withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
    // back function
    @objc func back(_ sender : UIBarButtonItem) {
        // push back
        //Segue kind of "present" we call "dismiss(animated:true)"
        self.dismiss(animated: true)
    }
    
}
