//
//  BackgroundMusicViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/18/22.
//

import UIKit

class BackgroundMusicViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Stop Music
    @IBAction func stopMusicButton(_ sender: Any) {
        AudioPlayer.stop()
    }
    
    //Start Music
    @IBAction func playMusicButton(_ sender: Any) {
        if AudioPlayer.isPlaying {
            AudioPlayer.pause()
            }
        AudioPlayer.currentTime = 0
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
    }
    
    
}
