//
//  IntroViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/2/22.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var logIn: UIButton!
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set background image
        let backgroundImage = UIImage(named: "BG1")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        // set font
        if #available(iOS 15.0, *) {
            logIn.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
            signUp.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
        } else {
            // Fallback on earlier versions
        }
    }

}
