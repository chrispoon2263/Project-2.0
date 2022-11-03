//
//  SignUpViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/2/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        Auth.auth().addStateDidChangeListener(){
            (auth, user) in
            if user != nil {
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    

    @IBAction func signUpButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){
            authResult, error in
            if let error = error as NSError? {
                self.errorLabel.text = "\(error.localizedDescription)"
            } else {
                self.errorLabel.text = ""
                self.performSegue(withIdentifier: "SegueIdentifierSignUp", sender: nil)
            }
        }
    }
}
