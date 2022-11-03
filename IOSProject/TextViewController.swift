//
//  ViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 10/21/22.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeguePictureVC",
           let nextVC = segue.destination as? PictureViewController{
            nextVC.receiveString = inputTextField.text!.replacingOccurrences(of: " ", with: "-")
            nextVC.delegate = self
        }
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        let text = inputTextField.text!.replacingOccurrences(of: " ", with: "-")
        print(text)
    }
}

