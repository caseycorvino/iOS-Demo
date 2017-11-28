//
//  LoginViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/2/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var EmailField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    
    @IBOutlet var LoginButton: UIView!
    
    @IBAction func loginButtonClicked(_ sender: AnyObject?){
        let email = EmailField.text!
        let password = PasswordField.text!
        let helping = Helper()
        if email == "" || password == "" {
            helping.displayAlertOK(title: "Invalid Inputs", message: "Please enter an email and a password", view: self)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                    
                } else {
                    helping.displayAlertOK(title: "Server Reported an Error", message: (error?.localizedDescription)!, view: self)
                }
            }
        }
    }
    @objc func swiped(gesture: UIGestureRecognizer){
            performSegue(withIdentifier: "loginToOpen", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        
        let helping = Helper()
        helping.putBorderOnButton(color: UIColor.white.cgColor, buttonView: LoginButton, radius: 20)
        helping.underlineTextField(color: UIColor.white.cgColor, field: EmailField)
        helping.underlineTextField(color: UIColor.white.cgColor, field: PasswordField)
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
