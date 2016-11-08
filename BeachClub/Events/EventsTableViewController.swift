//
//  EventsTableViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 11/21/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {

    var eventsDictionary: NSDictionary = NSDictionary()
    
    var eventNames: [String] = [String]()
    
    let tableViewRowHeight: CGFloat = 125.0
    
    // Define MintCream color: #F5FFFA  245,255,250
    let color1 = UIColor(red: 107.0/255.0, green: 225.0/255.0, blue: 253.0/255.0, alpha: 1)
    
    // Define OldLace color: #FDF5E6   253,245,230
    let color2 = UIColor(red: 107.0/255.0, green: 205.0/255.0, blue: 253.0/255.0, alpha: 1)
    
    // Define OldLace color: #FDF5E6   253,245,230
    let color3 = UIColor(red: 107.0/255.0, green: 185.0/255.0, blue: 253.0/255.0, alpha: 1)
    
    //Data To Display for next View
    var artistName = String()
    var photoName = String()
    var givenDate = String()
    var givenTime = String()
    var givenFee = String()
    var givenDescription = String()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Obtain the URL to the Events.plist file in subdirectory "plist Files"
        let eventsPlistURL : NSURL? = NSBundle.mainBundle().URLForResource("Events", withExtension: "plist")
        
        // Instantiate an NSDictionary object and initialize it with the contents of the Events.plist file.
        let eventsDict: NSDictionary? = NSDictionary(contentsOfURL: eventsPlistURL!)
       
        
        if let dictForEvents = eventsDict {
            
            self.eventsDictionary = dictForEvents
            
            
        }else {
            
            // Unable to get the file from the main bundle
            showErrorMessageFor("Events.plist")
            return
        }
        eventNames = eventsDictionary.allKeys as! [String]
        
        // Sort the names within itself in alphabetical order
        eventNames.sortInPlace { $0 < $1 }
        
     //   self.tableView.backgroundView = UIImageView(image: UIImage(named: "beachclubBackground.png"))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventNames.count
    }
    
    /*
    ------------------------------------
    Prepare and Return a Table View Cell
    ------------------------------------
    */
   

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let rowNumber: Int = indexPath.row    // Identify the row number
        
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        // CountryCellType, which was specified in the storyboard
        let cell: EventsTableViewCell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! EventsTableViewCell
        
        // Obtain the country code of the row
        let eventName: String = eventNames[rowNumber]
        
        let eventDataArray: [String] = eventsDictionary[eventName] as! [String]
        
        cell.eventDateLabel.text = eventDataArray[0]
        cell.eventArtistLabel.text = eventDataArray[1]
        cell.eventTimeLabel.text = "Gate Open: \(eventDataArray[2])"
        cell.eventFeeLabel.text = "Entrance Fee: \(eventDataArray[3])"
        cell.eventImageView.image = UIImage(named: eventDataArray[4])
        
        
        
        

        return cell
    }
    
    /*
    -----------------------------------
    MARK: - Table View Delegate Methods
    -----------------------------------
    */
    
    // Asks the table view delegate to return the height of a given row.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableViewRowHeight
    }
    
    /*
    Informs the table view delegate that the table view is about to display a cell for a particular row.
    Just before the cell is displayed, we change the cell's background color as MINT_CREAM for even-numbered rows
    and OLD_LACE for odd-numbered rows to improve the table view's readability.
    */
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        The remainder operator (RowNumber % 2) computes how many multiples of 2 will fit inside RowNumber
        and returns the value, either 0 or 1, that is left over (known as the remainder).
        Remainder 0 implies even-numbered rows; Remainder 1 implies odd-numbered rows.
        */
        if indexPath.row % 3 == 0 {
            // Set even-numbered row's background color to MintCream, #F5FFFA 245,255,250
            cell.backgroundColor = color1
            
        } else if indexPath.row % 3 == 1 {
            // Set odd-numbered row's background color to OldLace, #FDF5E6 253,245,230
            cell.backgroundColor = color2
        }
        
        else {
            // Set odd-numbered row's background color to OldLace, #FDF5E6 253,245,230
            cell.backgroundColor = color3
        }
    }
    
    //--------------------------
    // Selection of a Movies (Row)
    //--------------------------
    
    // Tapping a row (city) displays a youtube trailer
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let eventName = eventNames[indexPath.row]
        
        let eventDataArray: [String] = eventsDictionary[eventName] as! [String]
        
        artistName = eventDataArray[1]
        photoName = eventDataArray[4]
        givenDate = eventDataArray[0]
        givenTime = eventDataArray[2]
        givenFee = eventDataArray[3]
        givenDescription = eventDataArray[5]
        
        
        
        let index = photoName.rangeOfString(".")!.startIndex
        var name = photoName.substringToIndex(index)
        name += "B.png"
        
        photoName = name
        
        
        
        // Perform the segue named CityMap
        performSegueWithIdentifier("displayArtistSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    -------------------------
    MARK: - Prepare For Segue
    -------------------------
    */
    
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "displayArtistSegue" {
            // Obtain the object reference of the destination view controller
            let eventViewController: EventViewController = segue.destinationViewController as! EventViewController
            
            //Pass the data object to the destination view controller object
            eventViewController.artistName = artistName
            eventViewController.photoName = photoName
            eventViewController.givenFee = givenFee
            eventViewController.givenDate = givenDate
            eventViewController.givenTime = givenTime
            eventViewController.givenDescription = givenDescription
            
            
        }
    }


    
    /*
    -----------------------------
    MARK: - Display Error Message
    -----------------------------
    */
    func showErrorMessageFor(fileName: String) {
        
        /*
        Create a UIAlertController object; dress it up with title, message, and preferred style;
        and store its object reference into local constant alertController
        */
        let alertController = UIAlertController(title: "Unable to Access the File: \(fileName)!",
            message: "Possible causes: (a) No network connection, (b) Accessed file is misplaced, or (c) Server is down.",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // Present the alert controller by calling the presentViewController method
        presentViewController(alertController, animated: true, completion: nil)
    }

}
