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
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        currentLocation = nil

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let location: CLLocation = locations[locations.count - 1]
        
        if currentLocation == nil {
            currentLocation = location
            setCityAndUpdateTitle(currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
        }
        
        print("location: \(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Manager Error: Description ->\(error.localizedDescription) : Reason -> \(error.localizedFailureReason)")
    }
    
    func setCityAndUpdateTitle(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            let placeMark: CLPlacemark! = (placemarks?[0])!
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
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        newMemoryImage.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImage(sender: AnyObject) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createNewMemory(sender: AnyObject) {
        if let title = memoryTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Memory", inManagedObjectContext: context)!
            let memory = Memory(entity: entity, insertIntoManagedObjectContext: context)
           
            memory.setMemoryTitle(title)
            memory.setMemoryDescriptionTextField(memoryDescription.text)
            memory.setMemoryImage(newMemoryImage.image!)
            memory.setMemoryWeatherImage(UIImage(named: "Sunshine")!) // Change this, so that it reflects the weather!
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
    
    private func showAlert(titleAlert: String, message: String) {
        let alert = UIAlertController(title: titleAlert, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
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
