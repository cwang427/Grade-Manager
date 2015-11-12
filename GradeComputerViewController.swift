//
//  GradeComputerViewController.swift
//  Grade Manager
//
//  Created by Cassidy Wang on 11/5/15.
//  Copyright © 2015 Cassidy Wang. All rights reserved.
//

import UIKit

class GradeComputerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func login() {
        print("logging in")
    }
}
