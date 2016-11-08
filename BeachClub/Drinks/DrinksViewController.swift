//
//  DrinksViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/6/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var typeTableView: UITableView!
    @IBOutlet var scrollMenu: UIScrollView!
    @IBOutlet var upArrowBlack: UIImageView!
    @IBOutlet var downArrowBlack: UIImageView!
    
    // Create and initialize the dictionary to store the input data
    var dict_AutoMakers_AutoModels = [String: AnyObject]()
    
    
    // Other properties (instance variables) and their initializations
    let kScrollMenuWidth: CGFloat = 124
    var selectedDrinkType = ""
    var previousButton = UIButton(frame: CGRectMake(0, 0, 0, 0))
    
    
    
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //Keys
    var drinkTypes: [String] = [String]()
    var drinkNamesArray: [String] = [String]()
    var drinkInformation: [String] = [String]()
    
    var innerDict   = [String: AnyObject]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkTypes = applicationDelegate.dict_drinks.allKeys as! [String]
        
        
        /**********************
         * Set Background Colors
         **********************/
         
         /*     self.view.backgroundColor = UIColor.blackColor()
         upArrowBlack.backgroundColor = UIColor.blackColor()
         downArrowBlack.backgroundColor = UIColor.blackColor()
         scrollMenu.backgroundColor = UIColor.blackColor()*/
         
         /***********************************************************************
         * Instantiate and setup the buttons for the horizontally scrollable menu
         ***********************************************************************/
         
         // Instantiate a mutable array to hold the menu buttons to be created
        var listOfMenuButtons = [UIButton]()
        
        
        for i in 0 ..< drinkTypes.count {
            
            // Instantiate a button to be placed within the horizontally scrollable menu
            let scrollMenuButton = UIButton(type: UIButtonType.Custom)
            
            // dringType = Coctails ---------- i = 0
            let drinksForSelectedType: AnyObject? = applicationDelegate.dict_drinks[drinkTypes[i]]
            

            //[Mojito, Long Island]
            drinkNamesArray = drinksForSelectedType!.allKeys as! [String]
            
            let imageName = drinkTypes[i] + ".png"
            let drinkTypeLogo = UIImage(named: imageName)
            
            
            // Set the button frame at origin at (x, y) = (0, 0) with
            // button width  = kScrollMenuWidth = 124
            // button height = 60 pixels
            scrollMenuButton.frame = CGRectMake(0.0, 0.0, kScrollMenuWidth, 220)
            
            // Set the button image to be the auto maker's logo
            scrollMenuButton.setImage(drinkTypeLogo, forState: UIControlState.Normal)
            
            // Obtain the title (i.e., auto manufacturer name) to be displayed on the button
            let buttonTitle = drinkTypes[i]
            
            // The button width and height in points will depend on its font style and size
            let buttonTitleFont = UIFont(name: "Helvetica", size: 14.0)
            
            // Set the font of the button title label text
            scrollMenuButton.titleLabel?.font = buttonTitleFont
            
            // Compute the size of the button title in points
            let buttonTitleSize: CGSize = (buttonTitle as NSString).sizeWithAttributes([NSFontAttributeName:buttonTitleFont!])
            
            // Set the button title to the automobile manufacturer's name
            scrollMenuButton.setTitle(drinkTypes[i], forState: UIControlState.Normal)
            
            // Set the button title color to black when the button is not selected
            scrollMenuButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            // Set the button title color to red when the button is selected
            scrollMenuButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
            
            // Specify the Inset values for top, left, bottom, and right edges for the title
            scrollMenuButton.titleEdgeInsets = UIEdgeInsetsMake(25, -drinkTypeLogo!.size.width, -(drinkTypeLogo!.size.height + 5), 0.0)
            
            // Specify the Inset values for top, left, bottom, and right edges for the auto logo image
            scrollMenuButton.imageEdgeInsets = UIEdgeInsetsMake(-(buttonTitleSize.height + 5), 0.0, 0, -buttonTitleSize.width)
            
            scrollMenuButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            
            // Set the button to invoke the buttonPressed: method when the user taps it
            scrollMenuButton.addTarget(self, action: #selector(DrinksViewController.buttonPressed(_:)), forControlEvents: .TouchUpInside)
            
            // Add the constructed button to the list of buttons
            listOfMenuButtons.append(scrollMenuButton)
        }
        
        
        
        
        /***********************************************************************************************
         * Compute the sumOfButtonHeights = sum of the heights of all buttons to be displayed in the menu
         ***********************************************************************************************/
        
        var sumOfButtonHeights: CGFloat = 0.0
        
        for j in 0 ..< listOfMenuButtons.count {
            
            // Obtain the obj ref to the jth button in the listOfMenuButtons array
            let button: UIButton = listOfMenuButtons[j]
            
            // Set the button's frame to buttonRect
            var buttonRect: CGRect = button.frame
            
            // Set the buttonRect's y coordinate value to sumOfButtonHeights
            buttonRect.origin.y = sumOfButtonHeights
            
            // Set the button's frame to the newly specified buttonRect
            button.frame = buttonRect
            
            // Add the button to the vertically scrollable menu
            scrollMenu.addSubview(button)
            
            // Add the height of the button to the total height
            sumOfButtonHeights += button.frame.size.height
        }
        
        // Vertically scrollable menu's content height size = the sum of the heights of all of the buttons
        // Vertically scrollable menu's content height size = kScrollMenuHeight points
        scrollMenu.contentSize = CGSizeMake(kScrollMenuWidth, sumOfButtonHeights)
        
        /*******************************************************
        * Select and show the default auto maker upon app launch
        *******************************************************/
        
        // Hide left arrow
        upArrowBlack.hidden = true
        
        // The first auto maker on the list is the default one to display
        let defaultButton: UIButton = listOfMenuButtons[0]
        
        // Indicate that the button is selected
        defaultButton.selected = true
        
        previousButton = defaultButton
        selectedDrinkType = drinkTypes[0]
        
        // Display the table view object's content for the selected auto maker
        typeTableView.reloadData()
    }
    
    
    /*
    -----------------------------------
    MARK: - Method to Handle Button Tap
    -----------------------------------
    */
    // This method is invoked when the user taps a button in the horizontally scrollable menu
    func buttonPressed(sender: UIButton) {
        
        let selectedButton: UIButton = sender
        
        // Indicate that the button is selected
        selectedButton.selected = true
        
        if previousButton != selectedButton {
            // Selecting the selected button again should not change its title color
            previousButton.selected = false
        }
        
        previousButton = selectedButton
        
        selectedDrinkType = selectedButton.titleForState(UIControlState.Normal)!
        
        // Redisplay the table view object's content for the selected auto maker
        typeTableView.reloadData()
    }
    
    /*
    -----------------------------------
    MARK: - Scroll View Delegate Method
    -----------------------------------
    */
    
    // Tells the delegate when the user scrolls the content view within the receiver
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // The autoTableView object scrolling also invokes this method, in the case of which no action
        // should be taken since this method is created to handle only the scrollMenu object's scrolling.
        if scrollView == typeTableView {
            return
        }
        
        /*
        Content        = concatenated list of buttons
        Content Height = sum of all button heights, sumOfButtonHeights
        Content Width  = kScrollMenuWidth points
        Origin         = (x, y) values of the bottom left corner of the scroll view or content
        Sy             = Scroll View's origin y value
        Cy             = Content's origin y value
        contentOffset  = Cy - Sy
        
        Interpretation of the Arrows:
        
        IF scrolled all the way to the BOTTOM then show only DOWN arrow: indicating that the data (content) is
        on the lower side and therefore, the user must *** scroll UP *** to see the content.
        
        IF scrolled all the way to the TOP then show only UP arrow: indicating that the data (content) is
        on the upper side and therefore, the user must *** scroll DOWN *** to see the content.
        
        5 pixels used as padding
        */
        if scrollView.contentOffset.y <= 5 {
            // Scrolling is done all the way to the BOTTOM
            upArrowBlack.hidden   = true      // Hide Up arrow
            downArrowBlack.hidden  = false    // Show Down arrow
        }
        else if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) - 5 {
            // Scrolling is done all the way to the TOP
            upArrowBlack.hidden   = false     // Show Up arrow
            downArrowBlack.hidden  = true     // Hide Down arrow
        }
        else {
            // Scrolling is in between. Scrolling can be done in either direction.
            upArrowBlack.hidden   = false     // Show Up arrow
            downArrowBlack.hidden  = false    // Show Down arrow
        }
    }
    
    /*
    --------------------------------------
    MARK: - Table View Data Source Methods
    --------------------------------------
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Asks the data source to return the number of rows in a section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Obtain the array of auto model names for the selected auto maker
        let drinksForSelectedType: AnyObject? = applicationDelegate.dict_drinks[selectedDrinkType]
        
        //[Mojito, Long Island]
        let listOfDrinks = drinksForSelectedType!.allKeys as! [String]
        
        
        
        // Return the number of auto model names for the selected auto maker.
        // We subtract 1 because the first item is the name of the logo image file.
        
        return listOfDrinks.count
    }
    
    // Asks the data source to return a cell to insert in a particular table view location
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("'asa")
        // Identify the row number
        let rowNumber = indexPath.row
        
        // Obtain the array of auto model names for the selected auto maker
        let drinksForSelectedType: AnyObject? = applicationDelegate.dict_drinks[selectedDrinkType]
        
        // Convert the array to be a Swift array
        var listOfDrinks = drinksForSelectedType!.allKeys as! [String]
        
        listOfDrinks.sortInPlace { $0 < $1 }
        
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        // AutoTableViewCell, which was specified in the storyboard
        let cell: DrinksTableViewCell = tableView.dequeueReusableCellWithIdentifier("FoodTypeCell") as! DrinksTableViewCell
        
        innerDict = drinksForSelectedType! as! Dictionary
        let drinkInformation: [String] = innerDict[listOfDrinks[rowNumber]] as! [String]
        
        
        cell.drinkImageView.image = UIImage(named: drinkInformation[1])
        cell.productNameLabel.text = "\(rowNumber+1)) " + drinkInformation[0]
        cell.productPriceLabel.text = drinkInformation[3]
        cell.productIngredientLabel.text = drinkInformation[2]
        
        
        
        return cell
    }
    
    /*
    ----------------------------------
    MARK: - Table View Delegate Method
    ----------------------------------
    */
    
    // This method is invoked when the user taps a table view row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Identify the row number
        let rowNumber = indexPath.row
        
        // Obtain the array of auto model names for the selected auto maker
        let drinksForSelectedType: AnyObject? = applicationDelegate.dict_drinks[selectedDrinkType]
        
        // Convert the array to be a Swift array
        var listOfDrinks = drinksForSelectedType!.allKeys as! [String]
        
        listOfDrinks.sortInPlace { $0 < $1 }
        
        
        innerDict = drinksForSelectedType! as! Dictionary
        let drinkInformation: [String] = innerDict[listOfDrinks[rowNumber]] as! [String]
        
        
        let refreshAlert = UIAlertController(title: "\(drinkInformation[0])", message: "Do you want to rate \(drinkInformation[0])?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes!", style: .Default, handler: { (action: UIAlertAction!) in
            let myKey = listOfDrinks[rowNumber]
            var myIntKey: Int = Int(myKey)!
            myIntKey -= 100
            
            self.applicationDelegate.dict_drinks[self.selectedDrinkType]!.removeObjectForKey(myKey)
            self.applicationDelegate.dict_drinks[self.selectedDrinkType]!.setValue(drinkInformation, forKey: String(myIntKey))
            tableView.reloadData()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        let alertImageView = UIImageView(frame: CGRectMake(250, 0, 60, 100))
        alertImageView.image = UIImage(named: drinkInformation[1])
        
        refreshAlert.view.addSubview(alertImageView)
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        

        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}
