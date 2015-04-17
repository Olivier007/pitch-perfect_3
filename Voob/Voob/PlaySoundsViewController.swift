//
//  PlaySoundsViewController.swift
//  Voob
//
//  Created by Olivier on 4/15/15.
//  Copyright (c) 2015 Layton. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Declare globally
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)

        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

    
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()

    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
       
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.play()
        playAudioWithVariablePitch(1000)
        }
    
    
    
    
    
    
    @IBAction func playDarthVader(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithVariablePitch(-1000)
    }
    
    // The function which will allow the effects to work 
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
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
