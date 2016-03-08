//
//  VacationViewController.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/7/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit


class VacationViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    private var imageArray: NSMutableArray = NSMutableArray()

    @IBOutlet var vacationCarousel: iCarousel!
    
    override func viewDidLoad() {
        setup()
    }
    
    private func setup() {
        imageArray = ["Paris-1", "India-2", "London-3",  "Vancouver-4"]
        vacationCarousel.type = iCarouselType.InvertedCylinder
        vacationCarousel.contentMode = .ScaleAspectFill
        vacationCarousel .reloadData()
    }
    
    internal func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var imageView: UIImageView!
        if imageView == nil {
            imageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 300,height: 300))
            imageView.contentMode = .ScaleAspectFit
        } else {
            imageView as UIImageView
        }
        
        imageView.image = UIImage(named: "\(imageArray.objectAtIndex(index))")
        return imageView
    }
    
    internal func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return imageArray.count
    }
}
