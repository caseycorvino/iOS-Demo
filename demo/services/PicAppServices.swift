//
//  PicAppServices.swift
//  demo
//
//  Created by Casey Corvino on 11/16/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import Foundation

import UIKit
import FirebaseDatabase
import FirebaseStorage

class PicAppServices{
    
    var ref: DatabaseReference! = Database.database().reference()
    
    func uploadPost(postImage: UIImage, caption: String, ownerEmail: String,ownerID: String, view: UIViewController){
        let helping = Helper()
        
        let key = ref.child("Posts").childByAutoId().key
        
        uploadPic(key: key, pic: postImage, completionHandler: {url in
            let post = ["owner": ownerID,
                        "ownerEmail": ownerEmail,
                        "dateCreated": helping.formatDate(date: Date()),
                        "caption": caption,
                        "url": url?.absoluteString ?? "url error"//do this, get url in completion handler
                        ] as [String : Any]
            let childUpdates = ["/Posts/\(key)": post]
            self.ref.updateChildValues(childUpdates) { (error: Error?, dr: DatabaseReference) in
                let helping = Helper()
                if error != nil{
                    helping.displayAlertOK(title: "Server Reported an Error", message: (error?.localizedDescription)!, view: view)
                } else {
                    helping.displayAlertOK(title: "Success!", message: "Post Uploaded Succesfully", view: view)
                }
            }
        })
    }
    
    func uploadPic(key: String, pic: UIImage, completionHandler: @escaping (URL?)-> Void){
        
            guard let imageData = UIImageJPEGRepresentation(pic, 0.1) else {
                return completionHandler(nil)
            }
            Storage.storage().reference().child("Pics/\(key).jpeg").putData(imageData, metadata: nil, completion: { (metadata, error) in
                
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    completionHandler(nil)
                }
                let url = metadata?.downloadURL() // do something with this
                completionHandler(url)
            })
        
    }
    
    var postsFeed:[Post] = []
    func retrievePosts(view: PicAppViewController, completionHandler: @escaping () -> Void){
        print("retrieveinh posy")
        postsFeed = []
        ref.child("Posts").observe(.value, andPreviousSiblingKeyWith: { (ds: DataSnapshot, str: String?) in
            
            for child in ds.children {
                print("there are children")
                if let ch: DataSnapshot = child as? DataSnapshot{
                    let value = ch.value as? NSDictionary
                    let post = Post()
                    //post.dateCreated = value?.value(forKey: "dateCreated") as? String
                    post.ownerID = value?.value(forKey: "owner") as? String
                    post.ownerEmail = value?.value(forKey: "ownerEmail") as? String
                    post.caption = value?.value(forKey: "caption") as? String
                    post.imagePost = UIImage()
                    self.getPhotoForKey(key: ch.key, post: post, view: view)
                } else {
                    print("can't convert")
                }
            }
            print(ds.childrenCount)
            print(self.postsFeed.count);
            completionHandler()
        }) { (error: Error?) in
            if error != nil{
                print("ERROR ++++++++++++++++" + (error?.localizedDescription)!)
            }
        }
    }
    
//    func getPhotoForURL(durl: String?)->UIImage{
//        if(durl != nil){
//            let url = URL(string: durl!)
//            if let data = try? Data(contentsOf: url!){
//                return UIImage(data: data)!
//            }
//        }
//        return UIImage()
//    }
    
    func getPhotoForKey(key: String, post: Post, view: PicAppViewController){
        let ref = Storage.storage().reference().child("Pics/\(key).jpeg");
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                post.imagePost = image;
                self.postsFeed.append(post)
                print("post feed \(self.postsFeed.count)")
                view.postsFeed = self.postsFeed
                view.tableView.reloadData()
                
            }
        }
    }
    
    
    
    
//    func getPhotoForKeyAsync(key: String, post: Post){
//        let url = URL(string: "https://fir-ecca7.firebaseio.com/Pics/\(key).jpeg")
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url!){ //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    post.imagePost = UIImage(data: data)
//                    self.postsFeed.append(post)//if this way then remove append from
//                    //print("success")
//                }
//            } else {
//
//            }
//        }
 //   }
    
    func isValidCaption(cap: String)->Bool{
        if(cap.count > 0 && cap != "Caption..."){
            return true;
        }
        return false
    }
    
    func isValidImage(pic: UIImage?)->Bool{
        if pic != nil{
            return true;
        }
        return false
    }
    
}
