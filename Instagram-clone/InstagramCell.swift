//
//  InstagramCell.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 3/4/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import ParseUI
import Parse

extension NSDate {
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfMonth, fromDate: date, toDate: self, options: []).weekOfMonth
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: date, toDate: self, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: date, toDate: self, options: []).second
    }
    
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}

//let date1 = NSCalendar.currentCalendar().dateWithEra(1, year: 2014, month: 11, day: 28, hour: 5, minute: 9, second: 0, nanosecond: 0)!
//let date2 = NSCalendar.currentCalendar().dateWithEra(1, year: 2015, month: 8, day: 28, hour: 5, minute: 9, second: 0, nanosecond: 0)!

protocol InstagramCellDelegate {
    func intagramCellProfileImageTab(sender: AnyObject?)
}

class InstagramCell: PFTableViewCell {
    
    //@IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var profileView: PFImageView!
    
    var delegate : InstagramCellDelegate?
    let profileImageTapRecognizer = UITapGestureRecognizer()
    let usernameTapRecognizer = UITapGestureRecognizer()
    
    var instagramPost: PFObject! {
        didSet {
            
            self.photoView.layer.cornerRadius = 4.0
            self.photoView.clipsToBounds = true
            
            self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2
            self.profileView.clipsToBounds = true
            
            if let mediaData = instagramPost["media"] as? PFFile {
                self.photoView.file = mediaData
                self.photoView.loadInBackground()
            }
            self.captionLabel.text = instagramPost["caption"] as? String
            self.dateTimeLabel.text = NSDate().offsetFrom(instagramPost.createdAt!)
            
            let author = instagramPost["author"] as? PFUser
            self.authorLabel.text = author?.username!
            Post.getUserProfileImage((author?.username!)!, success: { (imageData: PFFile?) -> () in
                if let imageData = imageData {
                    self.profileView.file = imageData
                    self.profileView.loadInBackground()
                }
            }) { (error : NSError?) -> () in
                print(error?.localizedDescription)
            }
            profileImageTapRecognizer.addTarget(self, action: "tapGeustureRecognizer:")
            usernameTapRecognizer.addTarget(self, action: "tapGeustureRecognizer:")
            self.profileView.addGestureRecognizer(profileImageTapRecognizer)
            self.authorLabel.addGestureRecognizer(usernameTapRecognizer)
        }
    }
    
    /*
    * Delegate the tap gesture functionality to view controller.
    */
    func tapGeustureRecognizer(sender : AnyObject) {
        delegate?.intagramCellProfileImageTab(sender)
    }
}
