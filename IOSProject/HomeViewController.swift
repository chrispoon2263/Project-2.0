//
//  HomeViewController.swift
//  IOSProject
//
//  Created by chi hai on 10/21/22.
//

import UIKit

let imageSegueIdentifier = "ImageSegueIdentifier"

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == imageSegueIdentifier, let nextVC = segue.destination as? TextViewController {
            nextVC.delegate = self
        }
    }
    
    @IBAction func makeImageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
    }


}
