//
//  MyTripsViewController.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/5/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import UIKit

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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(1)
    }
}

// TODO: Simplify Code here

class CarouselCollectionViewLayout: UICollectionViewLayout {
    // This is a subclass of layout and as a result we need to handle all the parts of the Layout
    let itemSize = CGSize(width: 300, height: 300)
    
    // angleAtExtreme is just the ending value of where we want the caousel to stop and angle is just the starting point.
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItemsInSection(0) > 0 ?
            -CGFloat(collectionView!.numberOfItemsInSection(0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize().width -
            CGRectGetWidth(collectionView!.bounds))
    }
    
    //When the radius changes, recalculate everything
    var radius: CGFloat = 1500 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        // This ensures cells aren't spread too far apart
        return atan((itemSize.width + 250) / radius)
    }
    
    // Holds layout attribute instances
    var attributesList = [CarouselCollectionViewLayoutAttributes]()
    
    // Declare how big the Content of your collection should be.
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width,
            height: CGRectGetHeight(collectionView!.bounds))
    }
    
    // Tells the collection view that we will be using the CarouselCollectionViewLayoutAttributes and not the default Layout Attributes.
    override class func layoutAttributesClass() -> AnyClass {
        return CarouselCollectionViewLayoutAttributes.self
    }
    
    // prepareLayout is the first method called when the collection view apperas on screen.  This is where you create and store layout attributes. Very Important. 
    // You iterate over each item in the collection view and execute the closure.
    override func prepareLayout() {
        super.prepareLayout()
        
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        // map here creates a new array with the reuslts of the closure for each element in the range.
        // TODO: Make this a for loop
        attributesList = (0..<collectionView!.numberOfItemsInSection(0)).map { (i)
            -> CarouselCollectionViewLayoutAttributes in
            // 1 Create an instance of CoureselCollectionViewLayoutAttributes for each index path, and then set its size
            let attributes = CarouselCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i,
                inSection: 0))
            attributes.size = self.itemSize
            // 2 Position each item at the center of the screen
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
            // 3 Rotate each item by the amount anglePerItem * i
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            // This is the anchorPoint in which we set x and y coordinates. 
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

            return attributes
        }
    }
    
    // Returns an array of layout attributes for all of the cells and views in the specified rectangle.
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    // Returns the attributes for the item at the given idex path.
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
        -> UICollectionViewLayoutAttributes? {
            return attributesList[indexPath.row]
    }
    // This tells the collection view to invalidate it's layout as it scrolls, which calls prepareLayout().  This updates/recalculated the angular position of the cell.
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}

// TODO: Extract/Remove code from UICollectionViewLayoutAttributes and put it into CarouselCollectionViewLayout

class CarouselCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    // I subclassed collectionViewLayout but I also have to subclass the CollectionViewLayoutsAttributes

    // 1. Anchor Point is where the rotation happens around which isn't the center.
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    // 2. Transform willl be equal to the the angle.
    var angle: CGFloat = 0 {
        didSet {
            zIndex = Int(angle * -100)
            transform = CGAffineTransformMakeRotation(angle)
        }
    }

    // 3. UICollecionViewLayoutAttributes  needs to conform to NSCopying protocol because the attribute's objects can be copied internally when the collection view is performing a layout.  Override this method to gurantee that both the anchorPoint and angle properties are set when the object is copied.
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copiedAttributes: CarouselCollectionViewLayoutAttributes = super.copyWithZone(zone) as! CarouselCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}





