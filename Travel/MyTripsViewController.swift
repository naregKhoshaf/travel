//
//  MyTripsViewController.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/5/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import UIKit


protocol CardCarouselDelegate: class {
    func viewForCarousel(carousel: MyTripsViewController, atIndex index: NSInteger) -> UIView
    func numberOfItemsInCarousel(carousel: MyTripsViewController) -> NSInteger
    func carousel(carousel: MyTripsViewController, didSelectOrbAtIndex index: NSInteger)
}

class MyTripsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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


class CarouselCollectionViewLayout: UICollectionViewFlowLayout {
    let sizeItem = CGSize(width: 133, height: 173)
    
    var radius: CGFloat = 500 {
        didSet {
            invalidateLayout() //When the radius changes, recalculate everything
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius) // This ensures cells aren't spread too far apart
    }
    
    var attributesList = [CarouselCollectionViewLayoutAttributes]()
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width,
            height: CGRectGetHeight(collectionView!.bounds))
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return CarouselCollectionViewLayoutAttributes.self
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        attributesList = (0..<collectionView!.numberOfItemsInSection(0)).map { (i)
            -> CarouselCollectionViewLayoutAttributes in
            // 1
            let attributes = CarouselCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i,
                inSection: 0))
            attributes.size = self.itemSize
            // 2
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
            // 3
            attributes.angle = self.anglePerItem*CGFloat(i)
            
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

            return attributes
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
        -> UICollectionViewLayoutAttributes? {
            return attributesList[indexPath.row]
    }
}

class CarouselCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
    
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransformMakeRotation(angle)
        }
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copiedAttributes: CarouselCollectionViewLayoutAttributes = super.copyWithZone(zone) as! CarouselCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}





