//
//  UIViewController+DismissKeyboard.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 6/16/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

/** This extension code is used to hide the keyboard after a user has tapped a random place on the screen Can be called anywhere in the controllers by calling self.hideKeyboardWhenTappedAround() in the ViewDidLoad() method.
*/
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}