//
//  HomeViewController.swift
//  Travel
//
//  Created by Nareg Khoshafian on 3/4/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func myTripsButton(sender: AnyObject) {
        presentViewController(MyTripsViewController(), animated: true, completion: nil)
    }

}
