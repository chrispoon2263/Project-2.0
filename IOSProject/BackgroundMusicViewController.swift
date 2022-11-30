//
//  BackgroundMusicViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/18/22.
//

import UIKit

class BackgroundMusicViewController: UIViewController {

    
    @IBOutlet weak var segController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background image
        let backgroundImage = UIImage(named: "BG4")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
    //Segcontroller for to turn the music on/off
    @IBAction func segmentControllerChange(_ sender: Any) {
        switch segController.selectedSegmentIndex {
        case 0: // TURN OFF MUSIC
            AudioPlayer.stop()
        case 1: // TURN ON MUSIC
            if AudioPlayer.isPlaying {
                AudioPlayer.pause()
                }
            AudioPlayer.currentTime = 0
            AudioPlayer.prepareToPlay()
            AudioPlayer.numberOfLoops = -1
            AudioPlayer.play()
        default:
            AudioPlayer.stop()
        }
    }
}
