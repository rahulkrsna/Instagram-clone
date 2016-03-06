//
//  LoginViewController.swift
//  Instagram-clone
//
//  Created by Rahul Krishna Vasantham on 2/28/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                if error.code == 202 {
                    print("Username already taken")
                } else {
                    print(error.localizedDescription)
                }
            } else {
                print("user signup successful")
                self.performSegueWithIdentifier("LoginSuccessSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                print("Login successful")
                self.performSegueWithIdentifier("LoginSuccessSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
