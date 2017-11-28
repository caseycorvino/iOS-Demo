//
//  helper.swift
//  demo
//
//  Created by Casey Corvino on 11/1/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    func putBorderOnButton(color: CGColor, buttonView: UIView, radius: Int ){
        
        buttonView.layer.borderColor = color
        buttonView.layer.borderWidth = 1
        buttonView.layer.cornerRadius = CGFloat(radius)
        buttonView.layer.masksToBounds = true;
        
    }
    
    func underlineTextField(color: CGColor, field : UITextField){
        
        field.isEnabled = true;
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = color
        border.frame = CGRect(x: 0, y: field.frame.size.height - width, width:  field.frame.size.width, height: 2)
        
        border.borderWidth = width
        field.layer.addSublayer(border)
        
        
    }
    func displayAlertOK(title: String, message: String, view: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(test:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: test)
    }
    func isValidPass(test:String) -> Bool {
        let emailRegEx = "^(?=.*[a-z].*[a-z].*[a-z]).{8,30}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: test)
    }
    func formatDate(date: Date)->String{
        let format = DateFormatter()
        format.dateFormat = "MM-dd-yyyy"
        return format.string(from:date)
    }
    
    func resizeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}
