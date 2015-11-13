//
//  GradeComputerViewController.swift
//  Grade Manager
//
//  Created by Cassidy Wang on 11/5/15.
//  Copyright © 2015 Cassidy Wang. All rights reserved.
//

import UIKit
import Foundation

class GradeComputerViewController: UIViewController {
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Manage autologin information
        let userData = NSUserDefaults.standardUserDefaults()
        if let savedUsername = userData.stringForKey(""),
            let savedPassword = userData.stringForKey("") {
                saveCredentials(username: savedUsername, password: savedPassword)
        }
        
        //Dismiss keyboard if view is tapped
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Closes keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Adjusts view position according to keyboard position
    
    
    //Handles login process
    @IBAction func login() {
        print("logging in...")
    }
}
