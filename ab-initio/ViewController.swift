//
//  ViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // For mock data, to be deleted.
    //var countriesForMockImages = ["florence", "louvre-france", "copenhagen-denmark"]
    //var countriesForMockLabel = ["Italy", "France", "Denmark"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCellWithIdentifier("MemoryCell") as? MemoryCell {
//            
//            let img = UIImage(named: countriesForMockImages[indexPath.row])!
//            cell.configureCell(img, memoryCellText: countriesForMockLabel[indexPath.row])
//            
//            return cell
//        } else {
//            return MemoryCell()
//        }
        return UITableViewCell()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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