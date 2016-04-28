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
    

        // Do any additional setup after loading the view.
    }

    func captureImage() {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                allowsEditing = false
                sourceType = .Camera
                cameraCaptureMode = .Photo
                self.presentViewController(self, animated: true, completion: {})
            } else {
                handleAlert("Rear camera doesn't exits", message: "Application canot access the camera")
            }
        } else {
            handleAlert("Camera inaccessable", message: "Application cannot access the camera")
        }

    }
    
    func handleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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
