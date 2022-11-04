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
    var tempString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if inputTextField.text != ""{
            print("SENDING THIS TEXT TO NEXTVC: \(inputTextField.text!.replacingOccurrences(of: " ", with: "-"))")
            if segue.identifier == "SeguePictureVC",
               let nextVC = segue.destination as? PictureViewController{
                nextVC.receiveString = inputTextField.text!.replacingOccurrences(of: " ", with: "-")
                nextVC.delegate = self
            }
            
        } else {
            print("DID NOT SEND ANYTHING TO NEXTVC during SEGUE")
        }

    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
        if inputTextField.text != ""{
            performSegue(withIdentifier: "SeguePictureVC", sender: nil)
            
        } else{
            print("EMPTY TEXTFIELD")
            let alert = UIAlertController(
                title: "Invalid input",
                message: "Please enter words separated by space",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(alert, animated: true)
        }
    }
}
