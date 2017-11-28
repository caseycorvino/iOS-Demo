//
//  PostViewController.swift
//  demo
//
//  Created by Casey Corvino on 11/20/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit
import FirebaseAuth

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let helping = Helper();
        helping.putBorderOnButton(color: blue.cgColor, buttonView: PostButtonView, radius: 20);
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        imagePicker.delegate = self
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var CaptionTextView: UITextView!
    
    @IBOutlet var PostButtonView: UIView!
    
    @IBOutlet var PictureButtonView: UIButton!
    
    @IBAction func PictureButtonClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            PictureButtonView.setBackgroundImage(pickedImage, for: .normal)
            PictureButtonView.contentMode = .scaleAspectFit
        } else {
            //display alert
            let helping = Helper()
            helping.displayAlertOK(title: "Picture Selection Error!", message: "There was a problem loading your selected picture. Please try again", view: self)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PostButtonClicked(_ sender: Any) {
        let picServices = PicAppServices()
        
        let caption = CaptionTextView.text!;
        let postImage = PictureButtonView.backgroundImage(for: .normal)!
        
        if(picServices.isValidImage(pic: postImage) && picServices.isValidCaption(cap: caption)){
            let ownerID = (Auth.auth().currentUser?.uid)!
            let ownerEmail = (Auth.auth().currentUser?.email)!
            picServices.uploadPost(postImage: postImage, caption: caption, ownerEmail: ownerEmail, ownerID: ownerID, view: self)
            dismiss(animated: true, completion: nil)
        } else {
            let helping = Helper()
            helping.displayAlertOK(title: "Invalid Post!", message: "Please check your Image and Caption", view: self)
        }
    }
    
    @IBAction func CancelButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil);
    
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
