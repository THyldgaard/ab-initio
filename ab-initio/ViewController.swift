//
//  ViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memories = [Memory]()
//    var fetchedResultsController: NSFetchedResultsController! <-- For more complex results
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        
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

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("MemoryCell") as? MemoryCell {
            let memory = memories[indexPath.row]
            cell.configureCell(memory)
            
            return cell
        } else {
            return MemoryCell()
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    @IBAction func photoForNewMemory(sender: AnyObject) {
        // Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "How you would like to create your new memory?", preferredStyle: .ActionSheet)
        
        let cancleAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            action -> Void in // Dismisses the action sheet
        }
        
        let takePhotoAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default) {
            action -> Void in
            
            // Make something happen here ...
        }
        
        let fromLibraryAction: UIAlertAction = UIAlertAction(title: "From Library", style: .Default) {
            action -> Void in
            // Make something happen here ...
        }
        
        actionSheetController.addAction(cancleAction)
        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(fromLibraryAction)
        
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
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