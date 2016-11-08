//
//  OffersTableViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/5/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class OffersTableViewController: UITableViewController {

    
    var offersDictionary: NSDictionary = NSDictionary()
    var offerTypeNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 55
        
        // Obtain the URL to the Events.plist file in subdirectory "plist Files"
        let eventsPlistURL : NSURL? = NSBundle.mainBundle().URLForResource("Offers", withExtension: "plist")
        
        // Instantiate an NSDictionary object and initialize it with the contents of the Events.plist file.
        let eventsDict: NSDictionary? = NSDictionary(contentsOfURL: eventsPlistURL!)
        
        
        if let dictForEvents = eventsDict {
            
            self.offersDictionary = dictForEvents
            offerTypeNames = offersDictionary.allKeys as! [String]
            
            // Sort the names within itself in alphabetical order
            offerTypeNames.sortInPlace { $0 < $1 }
            
            
            
        }
        
        
    }


    /*
    --------------------------------------
    MARK: - Table View Data Source Methods
    --------------------------------------
    */
    
    // We are implementing a Grouped table view style as we selected in the storyboard file.
    
    //----------------------------------------
    // Return Number of Sections in Table View
    //----------------------------------------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return offerTypeNames.count
    }
    
    //---------------------------------
    // Return Number of Rows in Section
    //---------------------------------

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // Obtain the name of the given type
        let givenTypeName = offerTypeNames[section]
        
        // Obtain the list of movies in the given type as AnyObject
        let offerType: AnyObject? = offersDictionary[givenTypeName]
        
        return offerType!.count

    }
    
    //-----------------------------
    // Set Title for Section Header
    //-----------------------------
    
    // Set the table view section header to be the country name
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        
        return offerTypeNames[section]
    }
    
    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("offerCell", forIndexPath: indexPath) as UITableViewCell
        
        let sectionNumber = indexPath.section
        let rowNumber = indexPath.row
        
        //Find the inner dictionary which includes arrays of movie data
        let innerDict: AnyObject? = offersDictionary[offerTypeNames[sectionNumber]]
        
        
        // Obtain an unordered list of array names
        var offersContentArray: Array = innerDict!.allKeys as! [String]
        
        
        // Cell number 0 has the name of the movie
        cell.textLabel!.text = offersContentArray[rowNumber]
        //Cell number 1 has the cast of the movie
        cell.detailTextLabel!.text = innerDict![offersContentArray[rowNumber]] as? String
        
 
        
        return cell
    }
    
    




}
