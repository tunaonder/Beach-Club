//
//  MediaViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 11/30/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var cameraButton: UIButton!

    
    //CELL IDENTIFIER
    private let reuseIdentifier = "mediaCell"
    
    //App Delegate
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //Keys
    var dictKeys: [String] = [String]()
    //Selected Image Path
    var selectedImagePath = String()
    var selectedImageName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dictKeys = applicationDelegate.dict_photoLibrary.allKeys as! [String]
        
        cameraButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        collectionView.reloadData()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        
      
        //View controller which goes out of the app for a second
        let image = UIImagePickerController()
        image.delegate = self
        //Take photo from camera
        image.sourceType = UIImagePickerControllerSourceType.Camera
        //No edit before import the image
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)

        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //Create Unique Image Name
        let imageName = NSUUID().UUIDString
        
        
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            jpegData.writeToFile(imagePath, atomically: true)
            
        }
        
        //Define the new key according to number of elements
        let myKey = String(dictKeys.count)
        var myDataArray = [String]()
        
        //Done with photo picking
        dismissViewControllerAnimated(true, completion: nil)
        
      
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add Photo", message: "Name your new Photo!", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Photo"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            let textField = alert.textFields![0] as UITextField
            //Add photo name to array
            myDataArray.append(textField.text!)
            //Add unique image name for dictionary
            myDataArray.append(imageName)
            //Update Dictionary
            self.applicationDelegate.dict_photoLibrary.setValue(myDataArray, forKey: myKey)
            //Update current keys
            self.dictKeys = self.applicationDelegate.dict_photoLibrary.allKeys as! [String]
            //Reload Collection View
            self.collectionView.reloadData()
            
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)


    }
    

    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dictKeys.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //  let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        
        let rowNumber: Int = indexPath.row    // Identify the row number
      
        let cell: MediaCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MediaCollectionViewCell
        
        let myPhotoArray: [String]? = applicationDelegate.dict_photoLibrary[dictKeys[rowNumber]] as? [String]
        
       // let myPhotoPath: String? = applicationDelegate.dict_photoLibrary[dictKeys[rowNumber]] as? String
        
        let myPhotoPath = myPhotoArray![1]
        
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(myPhotoPath)

        
        let checkImage = NSFileManager.defaultManager()
        
        if (checkImage.fileExistsAtPath(imagePath)) {
            cell.imageView.image = UIImage(contentsOfFile: imagePath)
            
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(120, 120)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let rowNumber: Int = indexPath.row    // Identify the row number
      //  let myPhotoPath: String? = applicationDelegate.dict_photoLibrary[dictKeys[rowNumber]] as? String
        
        let myPhotoArray: [String]? = applicationDelegate.dict_photoLibrary[dictKeys[rowNumber]] as? [String]
        
        let myPhotoPath = myPhotoArray![1]
        
        selectedImagePath = getDocumentsDirectory().stringByAppendingPathComponent(myPhotoPath)
        selectedImageName = myPhotoArray![0]
        
        
        performSegueWithIdentifier("displayPhotoSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "displayPhotoSegue" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let displayViewController: MediaPhotoDisplayViewController = segue.destinationViewController as! MediaPhotoDisplayViewController
            displayViewController.imagePath = selectedImagePath
            displayViewController.imageName = selectedImageName
            
            
            
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
            message: "The file does not reside in the application's main bundle (project folder)!",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // Present the alert controller by calling the presentViewController method
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
