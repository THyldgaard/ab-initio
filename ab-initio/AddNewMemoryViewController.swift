//
//  AddNewMemoryViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddNewMemoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var memoryTitle: UITextField!
    @IBOutlet weak var memoryDescription: UITextView!
    @IBOutlet weak var newMemoryImage: UIImageView!
    @IBOutlet weak var addNewMemoryButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupImagePicker()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        currentLocation = nil

        
        // Setup Description Text View
        memoryDescription.layer.cornerRadius = 5
        // TODO: Figure out how to indend padding for textbox.
        memoryDescription.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let location: CLLocation = locations[locations.count - 1]
        
        if currentLocation == nil {
            currentLocation = location
            setCityAndUpdateTitle(currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("Location Manager Error: Description ->\(error.localizedDescription) : Reason -> \(error.localizedFailureReason)")
    }
    
    func setCityAndUpdateTitle(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            guard let placemarks = placemarks,
                let placeMark: CLPlacemark = placemarks[0] else { return }
            self.determineCityLocation(placeMark)
            
        }
    }
    
    private func determineCityLocation(placeMark: CLPlacemark) {
        if let city = placeMark.addressDictionary?["City"] as? NSString {
            self.autoUpdateMemoryTitle(city)
        }
    }
    
    private func autoUpdateMemoryTitle(title: NSString) {
        memoryTitle.text = title as String
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        newMemoryImage.image = image
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
    }
    
    private func showAlert(titleAlert: String, message: String) {
        let alert = UIAlertController(title: titleAlert, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func addImage(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "How you would like to create your new memory?", preferredStyle: .ActionSheet)
        
        let cancleAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            action -> Void in // Dismisses the action sheet
        }
        
        let takePhotoAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default) {
            action -> Void in
            self.setupImagePicker()
            if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
                if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                    self.imagePicker.allowsEditing = false
                    self.imagePicker.sourceType = .Camera
                    self.imagePicker.cameraCaptureMode = .Photo
                    self.presentViewController(self.imagePicker, animated: true, completion: {})
                } else {
                    TakePhoto().handleAlert("Rear camera doesn't exits", message: "Application canot access the camera")
                }
            } else {
                TakePhoto().handleAlert("Camera inaccessable", message: "Application cannot access the camera")
            }
        }
        
        let fromLibraryAction: UIAlertAction = UIAlertAction(title: "From Library", style: .Default) {
            action -> Void in
            self.setupImagePicker()
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(cancleAction)
        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(fromLibraryAction)
        
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)

    }
    
    @IBAction func createNewMemory(sender: AnyObject) {
        if let title = memoryTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            guard let entity = NSEntityDescription.entityForName("Memory", inManagedObjectContext: context) else { return }
            let memory = Memory(entity: entity, insertIntoManagedObjectContext: context)
           
            memory.setMemoryTitle(title)
            memory.setMemoryDescriptionTextField(memoryDescription.text)
            if let image = newMemoryImage.image {
                memory.setMemoryImage(image)
            }
            if let image = UIImage(named: "Sunshine") {
                memory.setMemoryWeatherImage(image)
            } // Change this, so that it reflects the weather!
            memory.setMemoryDate(NSDate())
            memory.setMemoryTemperature(22.2) // Change this, so that it reflects the weather!
            memory.setMemoryLatitude(currentLocation.coordinate.latitude)
            memory.setMemoryLongitude(currentLocation.coordinate.longitude)
            
            context.insertObject(memory)
            
            do {
                try context.save()
                self.navigationController?.popViewControllerAnimated(true)
            } catch {
                print("Could not save memory")
                showAlert("Alert", message: "Sorry, but the Memory couldn't be saved, please try again.")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
