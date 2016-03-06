//
//  UserViewController.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 3/5/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class UserViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userProfilePic: PFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // Do any additional setup after loading the view.
        self.userIdLabel.text = PFUser.currentUser()?.username
        
        getCurrentUserProfileImage()
        self.userProfilePic.layer.cornerRadius = 4.0
        self.userProfilePic.clipsToBounds = true
//        self.userProfilePic.layer.borderWidth = 2.0
//        self.userProfilePic.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if error == nil {
                print("Logged Out")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginController")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        }
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        presetImagePickerViewController()
    }
    
    func presetImagePickerViewController() {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        userProfilePic.image = editedImage
        
        Post.postUserProfileImage(editedImage) { (status : Bool, error: NSError?) -> Void in
            if(error == nil) {
                if status {
                    print("Image set")
                }
            } else {
                print(error?.localizedDescription)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func getCurrentUserProfileImage() {
        
        Post.getUserProfileImage((PFUser.currentUser()?.username!)!, success: { (userData: PFFile?) -> () in
            if let userData = userData {
                self.userProfilePic.file = userData
                self.userProfilePic.loadInBackground()
            }
        }) { (error: NSError?) -> () in
                print(error?.localizedDescription)
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
}
