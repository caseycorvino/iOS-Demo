//
//  segueFromLeft.swift
//  demo
//
//  Created by Casey Corvino on 11/1/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import Foundation
import UIKit

class SegueToLeft: UIStoryboardSegue
{
    override func perform() {
        
        let first = self.source.view as UIView!
        let second = self.destination.view as UIView!
        
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        second?.frame = CGRect.init(x: -width, y: 0.0, width: width, height: height);
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(second!, aboveSubview: first!)
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            first?.frame = (first?.frame.offsetBy(dx: width, dy: 0.0))!
            second?.frame = (second?.frame.offsetBy(dx: width, dy: 0.0))!
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                                animated: false,
                                completion: nil)
        }
        
    }
}
