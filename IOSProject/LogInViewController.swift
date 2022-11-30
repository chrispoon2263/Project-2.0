//
//  LogInViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 11/2/22.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var logIn: UIButton!
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        pwTF.delegate = self
        pwTF.isSecureTextEntry = true
        
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
            logIn.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
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
                self.emailTF.text = nil
                self.pwTF.text = nil
            }
        }
    }
    
    // When LogInButton clicked segue to LogInVC
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
