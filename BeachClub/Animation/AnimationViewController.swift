//
//  AnimationViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/5/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit
import AudioToolbox

class AnimationViewController: UIViewController {

    
    @IBOutlet var giftImageView: UIImageView!
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var rotating = false
    var giftSwiped = true
    var count = 0
    var gamePlayed  = 5
    var giftText = ""

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.text = "Shake Your Device or Swipe Up to Get a Special Deal. You can try \(gamePlayed) times!"
        
        /*
        ----------------
        MARK: - Swipe UP
        ----------------
        */
        // Create a Swipe Up Gesture Recognizer object and
        // Identify which method to invoke when the Swipe Up gesture occurs.
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(AnimationViewController.performAnimation(_:)))
        
        // Set the Swipe Gesture Recognizer Direction to Up
        swipeUpRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        
        // Add Swipe Up Gesture Recognizer to the View
        self.view.addGestureRecognizer(swipeUpRecognizer)
        
        /*
        ----------------
        MARK: - Swipe Left
        ----------------
        */
        // Create a Swipe Up Gesture Recognizer object and
        // Identify which method to invoke when the Swipe Up gesture occurs.
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(AnimationViewController.performAnimation2(_:)))
        
        // Set the Swipe Gesture Recognizer Direction to Up
        swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        
        // Add Swipe Up Gesture Recognizer to the View
        self.view.addGestureRecognizer(swipeLeftRecognizer)
        
        
        

        
    }
    
    func performAnimation(recognizer: UISwipeGestureRecognizer) {
        rotateCommand()

    }
    
    func performAnimation2(recognizer: UISwipeGestureRecognizer) {
        //Wheel Turning Currently
        if(!rotating){
            gamePlayed -= 1
            if(gamePlayed<1){
                var finalInstruction = "Ooppss! This is The Final Deal For You!"
                finalInstruction += giftText
                instructionLabel.text = finalInstruction
            }
            else{
                giftSwiped = true
                self.giftImageView.image = nil
                instructionLabel.text = "Shake Your Device or Swipe Up to Get a Special Deal. You can try \(gamePlayed) times!"
            }
        }
        
        
       
        
    }
    
    func rotateCommand(){
        if (rotating){
            rotating = false
            displayResult()
        }
        else{
            if (giftSwiped){
                rotating = true
                let randomNumber = Int(arc4random_uniform(UInt32(5)))
                count += randomNumber
                if (count%5 == 0) {
                    imageView.image = UIImage(named: "mojitoWheel")
                }
                else if (count%5 == 1){
                    imageView.image = UIImage(named: "cokeWheel")
                }
                else if (count%5 == 2){
                    imageView.image = UIImage(named: "mariachiWheel")
                }
                else if (count%5 == 3){
                    imageView.image = UIImage(named: "efesWheel")
                }
                else {
                    imageView.image = UIImage(named: "lemonadeWheel")
                }
                rotate()
                instructionLabel.text = "Shake Your Device or Swipe Up to Stop The Wheel!"
            }

        }
    }
    
    func displayResult(){
  
        
        if (count%5 == 0) {
            giftImageView.image = UIImage(named: "mojito")
            giftText = "%30 Off Mojito!"
        }
        else if (count%5 == 1){
            giftImageView.image = UIImage(named: "coke")
            giftText = "Free Coke!"
        }
        else if (count%5 == 2){
            giftImageView.image = UIImage(named: "mariachi")
            giftText = "%50 Off Mariachi!"
        }
        else if (count%5 == 3){
            giftImageView.image = UIImage(named: "efes")
            giftText = "%50 Off Efes!"
        }
        else {
            giftImageView.image = UIImage(named: "lemonade")
            giftText = "Free Lemonade!"
        }
        var giftText2 = giftText
        giftText2 += " Show This Screen to Bartender and Get This Deal or Swipe Left To Try Again!"
        giftSwiped = false
        instructionLabel.text = giftText2
    }
    
    
    
    func rotate(){
        
        UIView.animateWithDuration(0.3,
            delay: 0.0,
            options: .CurveLinear,
            animations: {self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, 3.14159)},
            completion: {finished in if self.rotating{self.rotate()} })
    }
    
    
    
    /******************************************************************
     MARK: - Shake Gesture Detection and Playing the Turkey Gobble Sound
     ******************************************************************/
     
     /*
     The TurkeyGobbleViewController object must be the first responder to be able to receive
     and handle motion events. The following two instance methods are used for this purpose.
     */
    
    override func canBecomeFirstResponder() -> Bool {
        // Indicate that the TurkeyGobbleViewController object can be the first responder
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Upon the view appearing, assign the TurkeyGobbleViewController object to be the first responder
        self.becomeFirstResponder()
    }
    
    // This method plays the turkey gobble sound if the detected motion is a Shake Gesture
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        // If the detected motion is a Shake Gesture
        if event!.subtype == UIEventSubtype.MotionShake {
            
            // Then, play the turkey gobble sound
            
            rotateCommand()
            
            
        }
        
    }
    

    

}
