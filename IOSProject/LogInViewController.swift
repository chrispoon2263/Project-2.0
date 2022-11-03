//
//  LogInViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/2/22.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwTF.isSecureTextEntry = true
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        Auth.auth().addStateDidChangeListener(){
            (auth, user) in
            if user != nil {
                self.emailTF.text = nil
                self.pwTF.text = nil
            }
        }
    }
    
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: pwTF.text!) {
            (authResult, error) in
            if let error = error as NSError?{
                self.errorMessageLabel.text = "\(error.localizedDescription)"
            } else{
                self.errorMessageLabel.text = ""
                self.performSegue(withIdentifier: "SegueIdentifierLogIn", sender: nil)
            }
        }
    }
    

}
