//
//  Memory+CoreDataProperties.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/28/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Memory {

    @NSManaged var date: String?
    @NSManaged var descriptionTextField: String?
    @NSManaged var imageMemory: NSData?
    @NSManaged var imageWeather: NSData?
    @NSManaged var temperature: NSNumber?
    @NSManaged var title: String?

}
