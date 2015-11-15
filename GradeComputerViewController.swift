//
//  GradeComputerViewController.swift
//  Grade Manager
//
//  Created by Cassidy Wang on 11/5/15.
//  Copyright © 2015 Cassidy Wang. All rights reserved.
//

import UIKit
import Foundation

class GradeComputerViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var windowView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calls function to dismiss keyboard if view is tapped
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    //////////////////////////////////////////////////////////////////
    //FUNCTIONALITY BLOCK: Move text field if obstructed by keyboard//
    //////////////////////////////////////////////////////////////////
    
    
    
    ///////////////////////////
    //END FUNCTIONALITY BLOCK//
    ///////////////////////////
    
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
