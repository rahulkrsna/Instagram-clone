//
//  Post.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 3/4/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    static let className = "Post"
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let post = PFObject(className: className)
        
        post["media"] = getPFFileFromImage(image, profileImage: false)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption!
        post["likesCount"] = 0
        post["commentsCount"] = 0
        post["createdAt"] = "\(NSDate())"
        
        post.saveInBackgroundWithBlock (completion)
    }
    
    /*
    * Get the PFFile from the UIImage as we save the PFFile on the DB.
    */
    class func getPFFileFromImage(image: UIImage?, profileImage: Bool) -> PFFile? {
        
        //Size variation depending on the type of the image.
        var size = CGSize(width: 320, height: 210)
        if(profileImage) {
            size.width = 100
            size.height = 100
        }
        
        if let image = image {
            if let image = resize(image, newSize: size) {
                if let imageData = UIImagePNGRepresentation(image) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
        }
        return nil
    }
    
    /*
     * Resize the image to the specified CGSize and return the UIImage.
    */
    class func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /*
     * Fetch Latest 20 images
    */
    class func fetchLatestImagesInfo(success: ([PFObject]?) -> (), failure: (NSError?) -> ()) {
        
        let query = PFQuery(className: className)
        query.includeKey("author")
//        query.whereKey("likesCount", greaterThanOrEqualTo: 0)
        query.orderByDescending("createdAt")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if(error == nil) {
                if let posts = posts {
                    success(posts)
                } else {
                    print("No Posts")
                }
            } else {
                print("Error: \(error?.localizedDescription)")
                failure(error)
            }
        }
    }
    
    /*
    * Save the Profile Image of an user
    */
    class func postUserProfileImage(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        
        let userPost = PFObject(className: "UserData")
        userPost["username"] = (PFUser.currentUser()?.username)!
        userPost["profilePic"] = getPFFileFromImage(image, profileImage: true)
        
        userPost.saveInBackgroundWithBlock (completion)
    }
    
    /*
    * Retrive the profile image of the user and return the PFFile through the success block.
    */
    class func getUserProfileImage(username: String, success: (PFFile?) -> (), failure: (NSError?) -> ()) {
        let query = PFQuery(className: "UserData")
        query.whereKey("username", equalTo: username)
        
        query.getFirstObjectInBackgroundWithBlock { (user: PFObject?, error: NSError?) -> Void in
            if(error == nil) {
                success(user!["profilePic"] as? PFFile)
            } else {
                failure(error)
            }
        }
    }
    
}
