//
//  ViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/1/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @objc func swiped(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.left:
                performSegue(withIdentifier: "openToSignUp", sender: nil)
            case UISwipeGestureRecognizerDirection.right:
                performSegue(withIdentifier: "openToLogin", sender: nil)
            default:
                break
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

