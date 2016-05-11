//
//  ViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memories = [Memory]()
    var fetchedResultsController: NSFetchedResultsController!
    //let imagePicker: UIImagePickerController! = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //imagePicker.delegate = self

    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("MemoryCell") as? MemoryCell {
            let memory = memories[indexPath.row]
            configureCell(memory, cell: cell)
            
            return cell
        } else {
            return MemoryCell()
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMemory", sender: indexPath)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            
            moc.deleteObject(memories[indexPath.row])
            appDelegate.saveContext()
            
            memories.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func configureCell(memory: Memory, cell: MemoryCell) {
        cell.mainMemoryImg.image = memory.getMemoryImage()
        cell.mainMemoryCellText.text = memory.getMemoryTitle()
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext // Grabbing the app delegate context.
        let fetchRequest = NSFetchRequest(entityName: "Memory") // Grapping all entities with name Recipe.
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.memories = results as! [Memory]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemory" {
            let indexPath = sender as! NSIndexPath
            let memoryViewController: SingleMemoryViewController = segue.destinationViewController as! SingleMemoryViewController
            memoryViewController.memoryCellData = memories[indexPath.row]
            
        } 
    }
    
    
}

// This extension code is used to hide the keyboard after a user has tapped a random place on the screen
// Can be called anywhere in the controllers by calling self.hideKeyboardWhenTappedAround() in the ViewDidLoad() method.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}