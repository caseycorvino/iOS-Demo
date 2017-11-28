//
//  SignUpViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/2/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var signUpButton: UIView!
    
    
    @IBAction func SignUpButtonClicked(_ sender: AnyObject){
        let email = emailField.text!
        let password = passwordField.text!
        
        let helping = Helper()
        if !helping.isValidEmail(test: email) {
            helping.displayAlertOK(title: "Invalid Email!",message: "Please enter a valid email", view: self)
        } else if !helping.isValidPass(test: password) {
            helping.displayAlertOK(title: "Invalid Password!",message: "Passwords must contain more than 8 characters and more than 3 lowercase letters", view: self)
        } else {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                    
                    let alertController = UIAlertController(title: "Sign Up Succesful!", message: "Please go to the login screen to sign in", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler:  { (action) -> Void in
                        self.performSegue(withIdentifier: "signUpToOpen", sender: nil)
                        alertController.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
        
                    helping.displayAlertOK(title: "Server Reported an Error", message: (error?.localizedDescription)!, view: self)

                }
            }
        }
    }
    
    
    
    @objc func swiped(gesture: UIGestureRecognizer){
                    performSegue(withIdentifier: "signUpToOpen", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let helping = Helper()
        helping.putBorderOnButton(color: UIColor.lightGray.cgColor, buttonView: signUpButton, radius: 20)
        helping.underlineTextField(color: pink.cgColor, field: emailField)
        helping.underlineTextField(color: pink.cgColor, field: passwordField)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //keyboard dismissed on touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
