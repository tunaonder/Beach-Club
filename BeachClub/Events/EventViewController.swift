//
//  EventViewController.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/3/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit
import AVFoundation

class EventViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var gateOpenLabel: UILabel!
    @IBOutlet var feeLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    
    var artistName = String()
    var photoName = String()
    var givenDate = String()
    var givenTime = String()
    var givenFee = String()
    var givenDescription = String()
    
    /*
    Declare audioPlayer as an Optional instance variable (property) to point to an
    AVAudioPlayer object. The initial value of nil implies that its value is absent.
    */
    var audioPlayer: AVAudioPlayer? = nil
    
    var newAudioPlayer: AnyObject? = nil
    /****************************
     MARK: - viewWillAppear Method
     ****************************/
     
     /*
     Just before the view becomes visible, create an AVAudioPlayer object for playing the hokiePokie.wav
     audio file and store its obj ref into the audioPlayer instance variable declared above.
     */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Find AudioFileName
        let index = photoName.rangeOfString("B")!.startIndex
        let audioFileName = photoName.substringToIndex(index)
        print(audioFileName)
        
        
        // Obtain the file path of type NSURL to the audio file hokiePokie.wav.
        let audioFileURL: NSURL? = NSBundle.mainBundle().URLForResource(audioFileName, withExtension: "wav", subdirectory: "AudioFiles")
        
        /*
        Create an AVAudioPlayer object for playing the hokiePokie.wav audio file.
        If the object creation is successful, the Optional local variable newAudioPlayer
        will have a value; otherwise, it will be nil implying that it has no value.
        */
        do {
            try newAudioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL!, fileTypeHint: nil)
        } catch {
            
            
        }
        // Unwrap the Optional newAudioPlayer. If it has a value, assign it to createdAudioPlayer.
        // Otherwise, assign nil implying that it has no value.
        if let createdAudioPlayer = newAudioPlayer {
            
            // An AVAudioPlayer object is successfully created. Assign its obj ref value to audioPlayer
            audioPlayer = createdAudioPlayer as? AVAudioPlayer
            
        } else {
            // AVAudioPlayer object creation failed!
            
            // Misspell the filename for URLForResource above to see this error message.
            print("AVAudioPlayer object creation failed!")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = artistName
        imageView.image = UIImage(named: photoName)
        dateLabel.text = givenDate
        gateOpenLabel.text = "Gate Open: " + givenTime
        feeLabel.text = "Entrance Fee: " + givenFee
        textView.text = givenDescription
        // Do any additional setup after loading the view.
        
    }
    
    /*******************************
     MARK: - viewWillDisappear Method
     *******************************/
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Just before the view is dismissed, covered, or otherwise hidden, stop the audio playing.
        audioPlayer!.stop()
        
        // Set the playback point in time to 0 second; that is, bring the audio to its beginning.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPointZero, animated: false)
    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        audioPlayer!.play()
        
    }
    
    @IBAction func pauseButtonPressed(sender: UIButton) {
        audioPlayer!.pause()
        
        
    }
    @IBAction func stopButtonPressed(sender: UIButton) {
        audioPlayer!.stop()
        
        // Set the playback point in time to 0 second; that is, bring the audio to its beginning.
        audioPlayer!.currentTime = 0
        
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
