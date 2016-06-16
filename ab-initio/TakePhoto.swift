//
//  TakePhoto.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/24/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class TakePhoto: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func handleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
