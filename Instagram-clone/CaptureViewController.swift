//
//  CaptureViewController.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 3/4/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var captionLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        userImageView.image = editedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        // Start the Pogress animation
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        if let image = userImageView.image {
            Post.postUserImage(image, withCaption: captionLabel.text!, withCompletion: { (status: Bool, error: NSError?) -> Void in
                // Hide Progress animation
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                if status {
                    print("image saved!")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let story = UIStoryboard(name: "Main", bundle: nil)
                        let vc = story.instantiateViewControllerWithIdentifier("UserLoginSuccess")
                        self.tabBarController?.showViewController(vc, sender: nil)
                    })
                }
            })
        }
    }
    
    @IBAction func onImageViewTap(sender: UITapGestureRecognizer) {
        
        presetImagePickerViewController()
    }
//    @IBAction func onTap(sender: UITapGestureRecognizer) {
//        print("here..")
//        presetImagePickerViewController()
//    }
    
}
