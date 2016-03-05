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
}
