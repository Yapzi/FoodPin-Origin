//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yapzi on 16/5/10.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    var restaurantLocations = ["Hong Kong": ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier"], "Sydney": ["Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso"], "New York": ["Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional"], "London": ["Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]]
    var restaurantTypes = ["Cafe Deadend": "Coffee & Tea Shop", "Homei": "Cafe", "Teakha": "Tea House", "Cafe Loisl": "Austrian / Causual Drink", "Petite Oyster": "French", "For Kee Restaurant": "Bakery", "Po's Atelier": "Bakery", "Bourke Street Bakery": "Chocolate", "Haigh's Chocolate": "Cafe", "Palomino Espresso": "American / Seafood", "Upstate": "American", "Traif": "American", "Graham Avenue Meats": "Breakfast & Brunch", "Waffle & Wolf": "Coffee & Tea", "Five Leaves": "Coffee & Tea", "Cafe Lore": "Latin American", "Confessional": "Spanish", "Barrafina": "Spanish", "Donostia": "Spanish", "Royal Oak": "British", "Thai Cafe": "Thai"]
    

    var restaurantImages = [String: [String]]()
    var restaurantTitles = [String]()
    var restaurantDict = [String: [String]]()
    var restaurantIsVisited = [String: [Bool]]()
    func creatRestaurantSections() {
        for restaurantName in restaurantNames {
            let restaurantKey = restaurantName.substringToIndex(restaurantName.startIndex.advancedBy(1))
            if var restaurantValue = restaurantDict[restaurantKey] {
                restaurantValue.append(restaurantName)
                restaurantDict.updateValue(restaurantValue, forKey: restaurantKey)
            } else {
                restaurantDict[restaurantKey] = [restaurantName]
            }
            let restaurantVisitedValue = [Bool](count: restaurantDict[restaurantKey]!.count, repeatedValue: false)
            restaurantIsVisited.updateValue(restaurantVisitedValue, forKey: restaurantKey)
            var restaurantImage = restaurantName.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
            restaurantImage = restaurantImage.stringByReplacingOccurrencesOfString("'", withString: "")
            restaurantImage = restaurantImage.stringByReplacingOccurrencesOfString("&", withString: "")
            if var restaurantImageValue = restaurantImages[restaurantKey] {
                restaurantImageValue.append(restaurantImage)
                restaurantImages.updateValue(restaurantImageValue, forKey: restaurantKey)
            } else {
                restaurantImages[restaurantKey] = [restaurantImage]
            }
        }
        restaurantTitles = [String](restaurantDict.keys)
        restaurantTitles.sortInPlace({$0 < $1})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatRestaurantSections()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let restaurantKey = restaurantTitles[section]
        if let restaurantValue = restaurantDict[restaurantKey] {
            return restaurantValue.count
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantTableViewCell
        let restaurantKey = restaurantTitles[indexPath.section]
        if let restaurantValue = restaurantDict[restaurantKey] {
            cell.NameLable.text = restaurantValue[indexPath.row]
            for (location, restaurantName) in restaurantLocations {
                for name in restaurantName {
                    if name == restaurantValue[indexPath.row] {
                        cell.LocationLable.text = location
                    }
                }
            }
        }
        if let restaurantImageValue = restaurantImages[restaurantKey] {
            cell.ThumbImageView.image = UIImage(named: restaurantImageValue[indexPath.row] + ".jpg")
            cell.ThumbImageView.layer.cornerRadius = 30
            cell.ThumbImageView.clipsToBounds = true
        }
        cell.TypeLable.text = restaurantTypes[cell.NameLable.text!]
        let restaurantVisitedValue = restaurantIsVisited[restaurantKey]
        if restaurantVisitedValue![indexPath.row] {
        cell.accessoryType = .Checkmark
        } else {
        cell.accessoryType = .None
        }
//    cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark: .None
    return cell
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return restaurantTitles.count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return restaurantTitles[section]
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What Do You Want To Do ?", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel , handler: nil)
//        optionMenu.addAction(cancelAction)
//        let callActionHandler = {(_: UIAlertAction) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unvailable", message: "Sorry, the call feature is not available yet. pleast try again later.", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)
//            }
//        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .Default, handler: callActionHandler)
//        let isVisitedAction = UIAlertAction(title: "I've Been Here", style: .Default, handler: {(_: UIAlertAction) -> Void in
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
//            let restaurantKey = self.restaurantTitles[indexPath.section]
//            var restaurantVisitedValue = self.restaurantIsVisited[restaurantKey]
//            restaurantVisitedValue![indexPath.row] = true
//            self.restaurantIsVisited.updateValue(restaurantVisitedValue!, forKey: restaurantKey)
//            })
//        let isNotVisitedAction = UIAlertAction(title: "I've Not Been Here", style: .Default, handler: {(_: UIAlertAction) -> Void in
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            cell?.accessoryType = .None
//            let restaurantKey = self.restaurantTitles[indexPath.section]
//            var restaurantVisitedValue = self.restaurantIsVisited[restaurantKey]
//            restaurantVisitedValue![indexPath.row] = false
//            self.restaurantIsVisited.updateValue(restaurantVisitedValue!, forKey: restaurantKey)
//            })
//        optionMenu.addAction(isNotVisitedAction)
//        optionMenu.addAction(callAction)
//        optionMenu.addAction(isVisitedAction)
//        self.presentViewController(optionMenu, animated: true, completion: nil)
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            restaurantNames.removeAtIndex(indexPath.row)
//            let indexSet = NSMutableIndexSet()
//            let restaurantKey = restaurantTitles[indexPath.section]
//            if restaurantDict[restaurantKey]?.count > 1 {
//                restaurantDict[restaurantKey]?.removeAtIndex(indexPath.row)
//                restaurantIsVisited[restaurantKey]?.removeAtIndex(indexPath.row)
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            } else {
//                indexSet.addIndex(indexPath.section)
//                restaurantDict.removeValueForKey(restaurantKey)
//                restaurantIsVisited.removeValueForKey(restaurantKey)
//                restaurantTitles.removeAtIndex(indexPath.section)
//                tableView.deleteSections(indexSet, withRowAnimation: .Fade)
//            }
//        }
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let restaurantKey = self.restaurantTitles[indexPath.section]
        let restaurantValue = self.restaurantDict[restaurantKey]
        let socialShare = UITableViewRowAction(style: .Default, title: "Share", handler: {(action, indexPath) -> Void in
            let defautText = "Let's Check It At " + restaurantValue![indexPath.row]
            if let imageToShare = UIImage(named: "cafelore") {
                let activityController = UIActivityViewController(activityItems: [defautText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
            })
        let DeleteRow = UITableViewRowAction(style: .Default, title: "Delete", handler: {(action, indexPath) -> Void in
            self.restaurantNames.removeAtIndex(indexPath.row)
            let indexSet = NSMutableIndexSet()
            if self.restaurantDict[restaurantKey]?.count > 1 {
                self.restaurantDict[restaurantKey]?.removeAtIndex(indexPath.row)
                self.restaurantIsVisited[restaurantKey]?.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else {
                indexSet.addIndex(indexPath.section)
                self.restaurantDict.removeValueForKey(restaurantKey)
                self.restaurantIsVisited.removeValueForKey(restaurantKey)
                self.restaurantTitles.removeAtIndex(indexPath.section)
                tableView.deleteSections(indexSet, withRowAnimation: .Fade)
            }
            })
        socialShare.backgroundColor = UIColor(red: 28/255, green: 165/255, blue: 253/255, alpha: 1.0)
        DeleteRow.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        return [socialShare, DeleteRow]
    }
    
    //    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    //        return restaurantTitles
    //    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                let restaurantKey = restaurantTitles[indexPath.section]
                if let restaurantImageForSection = restaurantImages[restaurantKey] {
                    destinationController.restaurantImage = restaurantImageForSection[indexPath.row] + ".jpg"
                }
                if let restaurantValue = restaurantDict[restaurantKey] {
                    destinationController.restaurantType = restaurantValue[indexPath.row]
                    for (location, restaurantName) in restaurantLocations {
                        for name in restaurantName {
                            if name == restaurantValue[indexPath.row] {
                                destinationController.restaurantLocation = location
                                destinationController.restaurantName = name
                            }
                        }
                    }
                }
            }
        }
    }
}
