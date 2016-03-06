//
//  User.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 2/29/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    var user: PFUser?
    
    init(user: PFUser) {
        self.user = user
    }
    
    static var _currentUser: PFUser?
    class var currentUser: PFUser {
        
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let data = defaults.objectForKey("currentUser") as? NSData
                if let data = data {
                do {
                    let user = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    _currentUser = user as? PFUser
                    } catch {
                        print("json desrialization error: \(error)")
                    }
                }
            }
            return _currentUser!
        }
        
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = _currentUser {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user, options: [])
                    defaults.setObject(data, forKey: "currentUser")
                }catch {
                    print("json serialization error: \(error)")
                }
            } else {
                defaults.setObject(nil, forKey: "currentUser")
            }
            defaults.synchronize()
        }
    }
    
}
