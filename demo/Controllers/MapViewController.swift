//
//  MapViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/9/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit
import  GoogleMaps
import FirebaseAuth

var fromRight = false
var fromLeft = false

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var map: GMSMapView!
    
    @IBOutlet var picAppButtonView: UIView!
    @IBOutlet var mapAppButtonView: UIView!
    @IBOutlet var settingsButtonView: UIView!
    
    @IBOutlet var addSpotButton: UIView!
   
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let helping = Helper()
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: picAppButtonView, radius: 30)
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: mapAppButtonView, radius: 30)
        helping.putBorderOnButton(color: UIColor.init(white: 1.0, alpha: 0.0).cgColor, buttonView: settingsButtonView, radius: 30)
        
        helping.putBorderOnButton(color: orange.cgColor, buttonView: addSpotButton, radius: 50)
        
        
        do {
            // Set the map style by passing a valid JSON string.
            let style = try String(contentsOfFile: "/Users/Code/Desktop/code/demo/demo/grayMap.json")
            map.mapStyle = try GMSMapStyle(jsonString: style)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        
        let spotsServices = SpotsServices()
        spotsServices.retrieveSpots(completionHandler: {
            
            self.map.clear()
            for spot in spotsServices.spotsFeed{
                let position = CLLocationCoordinate2D(latitude: spot.latitude!, longitude: spot.longitude!)
                let marker = GMSMarker(position: position)
                marker.title = spot.dateCreated
                
                if(spot.owner! == Auth.auth().currentUser?.uid){
                    marker.icon = helping.resizeImage(image: UIImage(named: "orangeCrosshair.png")!, scaledToSize: CGSize(width: 20, height: 20))
                } else {
                    marker.icon = helping.resizeImage(image: UIImage(named: "crosshair.png")!, scaledToSize: CGSize(width: 20, height: 20))
                }
                marker.map = self.map
            }
            
        })
        
        // Do any additional setup after loading the view.
        
        if fromRight {
            moveButtonViewLeft()
            fromRight = false
        }
        if fromLeft {
            moveButtonViewRight()
            fromLeft = false
        }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSpotButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Spot?", message: "A Spot will be added at your current location. Continue?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
            
            let spotServices = SpotsServices()
            spotServices.uploadSpot(lat: (self.userCoordinates?.latitude)!, lon: (self.userCoordinates?.longitude)!, userID: (Auth.auth().currentUser?.uid)!, view: self)
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func settingsButtonClicked(_ sender: Any) {
        fromLeft = true
        settingsButtonView.backgroundColor = pink;
        mapAppButtonView.backgroundColor = UIColor.lightGray
        moveButtonViewRight()
        performSegue(withIdentifier: "toSettings", sender: nil)
        
    }
    
    @IBAction func picButtonClicked(_ sender: Any) {
        fromRight = true
        picAppButtonView.backgroundColor = blue;
        mapAppButtonView.backgroundColor = UIColor.lightGray
        moveButtonViewLeft()
        performSegue(withIdentifier: "toPic", sender: nil)
        
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error" + error.localizedDescription)
    }
    
    var userCoordinates: CLLocationCoordinate2D?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations.last
        userCoordinates = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 12);
        self.map.camera = camera
        self.map.isMyLocationEnabled = true
        
        locationManager.stopUpdatingLocation()
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
