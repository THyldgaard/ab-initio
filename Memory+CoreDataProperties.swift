//
//  Memory+CoreDataProperties.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/20/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Memory {

    @NSManaged var imageMemory: NSData?
    @NSManaged var imageWeather: NSData?
    @NSManaged var title: String?
    @NSManaged var date: NSDate?
    @NSManaged var descriptionTextField: String?
    @NSManaged var temperature: NSNumber?

}
