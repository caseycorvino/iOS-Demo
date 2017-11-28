//
//  ChangeEmailViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/13/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChangeEmailViewController: UIViewController {

    @IBOutlet var newEmailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = "Cancel"
        navigationController?.navigationBar.tintColor = pink
        navigationController?.navigationBar.titleTextAttributes?.updateValue(UIColor.red, forKey: NSAttributedStringKey.foregroundColor)
        
        let helping = Helper()
        helping.underlineTextField(color: pink.cgColor, field: newEmailField)
       
        newEmailField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    @IBAction func updateEmailButtonClicked(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        user?.updateEmail(to: newEmailField.text!, completion: { (error: Error?) in
            if error != nil{
                let helping = Helper()
                helping.displayAlertOK(title: "Server Reported an Error", message: (error?.localizedDescription)! , view: self)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            }
            )
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
