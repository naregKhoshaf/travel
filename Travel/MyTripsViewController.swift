//
//  MyTripsViewController.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/5/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

class MyTripsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tripsCollectionView: UICollectionView!
    
    private let reuseIdentifier = "cellReuse"
    private var imageArray = ["Paris-1", "India-2", "London-3",  "Vancouver-4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MyTripsCollectionViewCell", bundle: nil)
        tripsCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = tripsCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyTripsCollectionViewCell
        let photo = imageArray[indexPath.row]
        cell.setCellImage(photo)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = CGRectGetWidth(collectionView.bounds)
        let cellWidth = screenWidth
        return CGSize(width: cellWidth - 30, height: cellWidth - 30)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(1)
    }
}
