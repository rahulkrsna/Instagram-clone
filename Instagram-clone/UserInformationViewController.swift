//
//  UserInformationViewController.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 3/5/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import ParseUI

class UserInformationViewController: UIViewController {

    @IBOutlet weak var profileImage: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var imageInfo: PFFile!
    var usernameInfo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.profileImage.layer.cornerRadius = 4.0
        self.profileImage.clipsToBounds = true
        
        self.profileImage.file = imageInfo
        self.profileImage.loadInBackground()
        self.usernameLabel.text = usernameInfo
    }

    @IBAction func onBack(sender: AnyObject) {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserLoginSuccess")
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
}
