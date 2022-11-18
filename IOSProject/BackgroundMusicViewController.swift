//
//  BackgroundMusicViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/18/22.
//

import UIKit
import AVFoundation

class BackgroundMusicViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    @IBAction func stopMusicButton(_ sender: Any) {
        AudioPlayer.stop()
    }
    
    
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
