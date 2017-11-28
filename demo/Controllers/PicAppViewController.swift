//
//  PicAppViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/10/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit

class PicAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var postsFeed:[Post] = [];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath) as? PicTableViewCell
        if(cell != nil){
            cell!.postImageView.image = postsFeed[indexPath.row].imagePost!
            cell!.ownerLabel.text = postsFeed[indexPath.row].ownerEmail!
            cell!.captionTextView.text = postsFeed[indexPath.row].caption!
            print("return cell")
            return cell!;
        }
        print("return ")
        return UITableViewCell();
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    @IBOutlet var picAppButtonView: UIView!
    @IBOutlet var mapAppButtonView: UIView!
    @IBOutlet var settingsButtonView: UIView!
    
    @IBOutlet var uploadPicButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let helping = Helper()
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: picAppButtonView, radius: 30)
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: mapAppButtonView, radius: 30)
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: settingsButtonView, radius: 30)
        helping.putBorderOnButton(color:  UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: uploadPicButtonView, radius: 40)
        
        if fromRight {
            moveButtonViewLeft()
            fromRight = false
        }
        if fromLeft{
            moveButtonViewRight()
            fromLeft = false
        }
        tableView.allowsSelection = false
        // Do any additional setup after loading the view.
        let picServices = PicAppServices()
        picServices.retrievePosts(view: self, completionHandler: {
            self.postsFeed = picServices.postsFeed
            self.tableView.reloadData()
        })
    }
    
    @IBAction func mapButtonClicked(_ sender: Any) {
        fromLeft = true
        picAppButtonView.backgroundColor = UIColor.lightGray
        mapAppButtonView.backgroundColor = orange;
        moveButtonViewRight()
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    @IBAction func settingsButtonClicked(_ sender: Any) {
        fromRight = true
        picAppButtonView.backgroundColor = UIColor.lightGray
        settingsButtonView.backgroundColor = pink;
        moveButtonViewLeft()
        performSegue(withIdentifier: "toSettings", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
