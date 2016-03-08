//
//  MyTripsCollectionViewCell.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/4/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

class MyTripsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tripCellImageView: UIImageView!
    
    func setCellImage(photo: String) {
        tripCellImageView.image = UIImage(named: photo)
    }
    // superclass implementation to apply teh default properties like center and transform, but since anchorPoint is a custom property, you have to apply that manually.  Update center.y to the center of the layout circle to compensate for the change in anchorPoint.y
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CarouselCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
    }
}
