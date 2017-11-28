//
//  SettingsViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/9/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var buttonMenuView: UIView!
    
    @IBOutlet var table: UITableView!
    @IBOutlet var picAppButtonView: UIView!
    @IBOutlet var mapAppButtonView: UIView!
    @IBOutlet var settingsButtonView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButtonView.backgroundColor = pink
        
        let helping = Helper()
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: picAppButtonView, radius: 30)
         helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: mapAppButtonView, radius: 30)
         helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: settingsButtonView, radius: 30)
        
        if fromLeft {
            moveButtonViewRight()
            fromLeft = false
        }
        if fromRight{
            moveButtonViewLeft()
            fromRight = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mapButtonClicked(_ sender: Any) {
        fromRight = true
        mapAppButtonView.backgroundColor = orange;
        settingsButtonView.backgroundColor = UIColor.lightGray
        moveButtonViewLeft()
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    @IBAction func picButtonClicked(_ sender: Any) {
        fromLeft = true
        picAppButtonView.backgroundColor = blue;
        settingsButtonView.backgroundColor = UIColor.lightGray
        moveButtonViewRight()
        performSegue(withIdentifier: "toPic", sender: nil)
    }
    
    let settingsCategories = ["My Account", "More" ]
    
    let settingsArray = [["Change Email"], ["About", "Contact", "Terms of Services and Privacy Policy"]]
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsCategories[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsCategories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = settingsArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [0,0]:
            performSegue(withIdentifier: "toChangeEmail", sender: nil)
            break;
        case [1,0]:
            if let url = URL(string: "http://caseycorvino.co") {
                UIApplication.shared.open(url)
            }
            break;
        case [1,1]:
            if let url = URL(string: "mailto:caseycorvino@nyu.edu") {
                UIApplication.shared.open(url)
            }
            break;
        case [1,2]:
            if let url = URL(string: "http://caseycorvino.co/PrivacyPolicy-TOS.html") {
                UIApplication.shared.open(url)
            }
            break;
        default:
            break;
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func moveButtonViewRight(){
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.picAppButtonView?.frame = (self.picAppButtonView?.frame.offsetBy(dx: UIScreen.main.bounds.size.width, dy: 0.0))!
            self.mapAppButtonView?.frame = (self.mapAppButtonView?.frame.offsetBy(dx: UIScreen.main.bounds.size.width, dy: 0.0))!
            self.settingsButtonView?.frame = (self.settingsButtonView?.frame.offsetBy(dx: UIScreen.main.bounds.size.width, dy: 0.0))!

        }) { (Finished) -> Void in
            
        }
    }
    
    func moveButtonViewLeft(){
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.picAppButtonView?.frame = (self.picAppButtonView?.frame.offsetBy(dx: -UIScreen.main.bounds.size.width, dy: 0.0))!
            self.mapAppButtonView?.frame = (self.mapAppButtonView?.frame.offsetBy(dx: -UIScreen.main.bounds.size.width, dy: 0.0))!
            self.settingsButtonView?.frame = (self.settingsButtonView?.frame.offsetBy(dx: -UIScreen.main.bounds.size.width, dy: 0.0))!
        }) { (Finished) -> Void in
            
        }
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                navigationController?.isNavigationBarHidden = false
                performSegue(withIdentifier: "logout", sender: nil)
                
            } catch let error as NSError {
                let helping = Helper()
                helping.displayAlertOK(title: "Server Reported an Error", message: (error.debugDescription), view: self)
            }
        }
        
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
