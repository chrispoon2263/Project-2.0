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
        if inputTextField.text != "" && isValidInput(urlString: inputTextField.text!){
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
        
        // Check for special charcters if not raise alert
         if !isValidInput(urlString: inputTextField.text!){
            print("UNKOWN CHARACTERS")
            let alert = UIAlertController(
                title: "Unkown Characters",
                message: "Please do not enter special characters",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(alert, animated: true)
             
        // check for empty string if not raise alert
         } else if inputTextField.text == ""{
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
        // else string should be valid and performe segue to
         } else{
             performSegue(withIdentifier: "SeguePictureVC", sender: nil)
        }
    }
    
    func isValidInput(urlString: String) ->  Bool {

        for chr in urlString {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z")) && !(chr == " "){
                     return false
                  }
               }
        return true
    }
    
}
