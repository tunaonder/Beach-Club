//
//  MediaPhotoDisplayViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/3/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class MediaPhotoDisplayViewController: UIViewController {

    var imageName = String()
    var imagePath = String()
  
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = imageName

        let checkImage = NSFileManager.defaultManager()
        
        if (checkImage.fileExistsAtPath(imagePath)) {
            imageView.image = UIImage(contentsOfFile: imagePath)
            
        }
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
