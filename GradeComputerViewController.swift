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
    
    
    @IBOutlet weak var windowView: UIView!
    @IBOutlet weak var loginWindowCenter: NSLayoutConstraint!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calls function to dismiss keyboard if view is tapped
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        let swipe: UIGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(swipe)
        
        //Add keyboard notification observers when view has loaded
        addKeyboardNotifications()
        
        print(windowView.center)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Removes keyboard notification observers when view disappears
        removeKeyboardNotifications()
    }

    //////////////////////////////////////////////////////////////////
    //FUNCTIONALITY BLOCK: Move text field if obstructed by keyboard//
    //////////////////////////////////////////////////////////////////
    
    func addKeyboardNotifications() {
        //Adds notifications for keyboard show/hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        //Removes notifications for keyboard show/hide
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
//        //Adjust view according to keyboard size
//        let info: NSDictionary = notification.userInfo!
//        
//        let keyboardEndFrame = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        let keyboardHeight = keyboardEndFrame.height
//        
//        self.view.frame.origin.y -= keyboardHeight
        
        if let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue {
                
                let keyboardHeight = keyboardFrame().height
                let newConstant = -10 - (keyboardHeight/3.0)
                
                if newConstant == loginWindowCenter.constant { return }
                
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
                    self.loginWindowCenter.constant = newConstant
                    self.view.layoutIfNeeded()
                    }, completion: nil)
                
        }
        
        print(windowView.center)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            self.windowView.center = self.view.center
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
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
