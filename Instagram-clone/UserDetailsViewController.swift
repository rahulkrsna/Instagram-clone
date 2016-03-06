//
//  UserDetailsViewController.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 2/29/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class UserDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, InstagramCellDelegate {
    
    @IBOutlet var tableView: UITableView!
    var POSTS : [PFObject]?
    var userProfileImage: PFFile?
    var username:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadImagesFromCloud()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = POSTS {
            return posts.count
        } else {
            return 0
        }
    }
    
//    @IBAction func onTap(sender: UITapGestureRecognizer) {
//        let view = sender.view
//        let cell = view?.superview?.superview as! InstagramCell
//        userProfileImage = cell.profileView.file
//        username = cell.authorLabel.text
////        let indexPath = tableView.indexPathForCell(cell)
////        let postObject = POSTS![indexPath!.row]
//        self.performSegueWithIdentifier("UserInformationSegue", sender: nil)
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        Cell.instagramPost = POSTS![indexPath.row]
        Cell.delegate = self
        Cell.layer.borderWidth = 1.0
        Cell.layer.borderColor = UIColor.blackColor().CGColor
        return Cell
    }
    
    func loadImagesFromCloud() {
        Post.fetchLatestImagesInfo({ (posts: [PFObject]?) -> () in
            if let posts = posts {
                self.POSTS = posts
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.tableView.reloadData()
            } else {
                print("No Posts!")
            }
        }) { (error: NSError?) -> () in
                print("Error: \(error?.localizedDescription)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "UserInformationSegue" {
            let userInformationViewController = segue.destinationViewController as! UserInformationViewController
            userInformationViewController.usernameInfo = username!
            userInformationViewController.imageInfo = userProfileImage!
        }
    }
    
    func intagramCellProfileImageTab(sender: AnyObject?) {
        
        let recog = sender as! UITapGestureRecognizer
        let view = recog.view
        let cell = view?.superview?.superview as! InstagramCell
        userProfileImage = cell.profileView.file
        username = cell.authorLabel.text
        self.performSegueWithIdentifier("UserInformationSegue", sender: nil)
    }
}
