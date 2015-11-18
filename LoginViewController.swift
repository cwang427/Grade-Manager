//
//  GradeComputerViewController.swift
//  Grade Manager
//
//  Created by Cassidy Wang on 11/5/15.
//  Copyright © 2015 Cassidy Wang. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //TODO: Try NSUserDefaults
    
    let keychainInfo = KeychainAccess()
    var activeField: UITextField?
    var switchStatus: Bool = true //TODO: need to store this value
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginWindow: UIView!
    @IBOutlet weak var loginWindowCenter: NSLayoutConstraint!
    @IBOutlet weak var saveInfoSwitch: UISwitch!
    
    override func viewWillAppear(animated: Bool) {
        setSavedUserInfo()
        saveInfoSwitch.setOn(switchStatus, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Override username and password events
        usernameField.delegate = self
        passwordField.delegate = self
        
        //Calls function to dismiss keyboard if view is touched
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //Add keyboard notification observers when view has loaded
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Removes keyboard notification observers when view disappears
        removeKeyboardNotifications()
    }

    //Fills fields with saved user info
    func setSavedUserInfo() {
        if let storedPassword = keychainInfo.getPasscode("edu.gatech.cassidy.password") {
            passwordField.text = String(storedPassword)
        }
    }
    
    //Closes keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }

    //Adds notifications for keyboard show/hide
    func addKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Removes notifications for keyboard show/hide
    func removeKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Configures return buttons on username and password field keyboards
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.passwordField {
            textField.resignFirstResponder()
            attemptLogin()
        } else if textField == self.usernameField {
            self.passwordField.becomeFirstResponder()
        }
        return true
    }
    
    //FUNCTIONALITY BLOCK 1: Move text field if obstructed by keyboard
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        //Adjust view according to keyboard size
        let userInfo = notification.userInfo!
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
        
        //Establishes location of top of keyboard relative to view coordinates
        let keyboardTop = self.view.frame.height - keyboardEndFrame!.height
        
        //Distance from center of login window to top of keyboard
        let windowCenterToKeyboardTop = keyboardTop - loginWindow.center.y
        
        //Distance from bottom of field to center of login window (remember that field coordinates are relative to the login window superview)
        if usernameField.isFirstResponder() {
            activeField = usernameField
        } else if passwordField.isFirstResponder() {
            activeField = passwordField
        }
        if let field = activeField {
            let fieldCenter = field.center.y + (self.view.frame.height/2.0 - loginWindow.frame.height/2.0)
            let fieldBottom = fieldCenter + (field.frame.height/2.0)
            let fieldToWindowCenter = loginWindow.center.y - fieldBottom
        
            //Moves field to center location, moves center location to top of keyboard
            let newConstant = -10 + fieldToWindowCenter + windowCenterToKeyboardTop
            
            if newConstant == loginWindowCenter.constant { return }
            
            //Find keyboard animation duration
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
            
            //Move view with keyboard animation
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseInOut], animations: {
                    self.loginWindowCenter.constant = newConstant
                    self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseInOut], animations: {
            self.loginWindowCenter.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //END FUNCTIONALITY BLOCK 1

    //FUNCTIONALITY BLOCK 2: Handles login process and keychain
    
    @IBAction func attemptLogin() {
        if !usernameField.hasText() || !passwordField.hasText() {
            shakeItOff(self.loginWindow)
            return
        }
        login()
    }
    
    func login() {
        print("logging in...")
        if saveInfoSwitch.on {
            keychainInfo.setPasscode("edu.gatech.cassidy.password", passcode: passwordField.text!)
        } else {
            keychainInfo.setPasscode("edu.gatech.cassidy.password", passcode: "")
        }
    }

    //END FUNCTIONALITY BLOCK 2
    
    //Shakes view
    func shakeItOff(view: UIView) {
        let animations : [CGFloat] = [20.0, -20.0, 10.0, -10.0, 3.0, -3.0, 0]
        for i in 0 ..< animations.count {
            let frameOrigin = CGPointMake(view.frame.origin.x + animations[i], view.frame.origin.y)
            
            UIView.animateWithDuration(0.1, delay: NSTimeInterval(0.1 * Double(i)), options: [], animations: {
                view.frame.origin = frameOrigin
                }, completion: nil)
        }
    }
}
