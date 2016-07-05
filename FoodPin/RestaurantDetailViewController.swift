//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Yapzi on 16/5/15.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNames: UILabel!
    @IBOutlet var restaurantLocations: UILabel!
    @IBOutlet var restaurantTypes: UILabel!
    var restaurantImage = ""
    var restaurantName = ""
    var restaurantLocation = ""
    var restaurantType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImageView.image = UIImage(named: restaurantImage)
        restaurantNames.text = restaurantName
        restaurantLocations.text = restaurantLocation
        restaurantTypes.text = restaurantType

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
