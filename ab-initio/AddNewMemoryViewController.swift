//
//  AddNewMemoryViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import CoreData

class AddNewMemoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var memoryTitle: UITextField!
    @IBOutlet weak var memoryDescription: UITextView!
    @IBOutlet weak var newMemoryImage: UIImageView!
    @IBOutlet weak var addNewMemoryButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

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
