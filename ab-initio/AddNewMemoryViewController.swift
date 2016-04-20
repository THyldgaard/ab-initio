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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
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
           
            memory.title = title
            memory.descriptionTextField = memoryDescription.text
            memory.setMemoryImage(newMemoryImage.image!)
            memory.setWeatherImage(newMemoryImage.image!) // Change this!
            memory.date = NSDate()
            memory.temperature = 22.2
            
            context.insertObject(memory)
            
            do {
                try context.save()
            } catch {
                print("Could not save memory")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
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
