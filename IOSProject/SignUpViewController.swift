//
//  SignUpViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/2/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Instance Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        // set background image
        let backgroundImage = UIImage(named: "BG1")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        if #available(iOS 15.0, *) {
            signUp.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
        } else {
            // Fallback on earlier versions
        }
        }
    
    // MARK: - ViewDidDisappear
    // upon leaving the screen blank out the textfields
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
    
    // When SignUp Button is pressed segue to SignupVC
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
    
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
