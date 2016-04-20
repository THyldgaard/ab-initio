//
//  Memory.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/20/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Memory: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func setMemoryImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.imageMemory = data
    }
    
    func setWeatherImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.imageWeather = data
    }
    
    func getMemoryImage() -> UIImage {
        let img = UIImage(data: self.imageMemory!)!
        return img
    }
    
    func getWeatherImage() -> UIImage {
        let img = UIImage(data: self.imageWeather!)!
        return img
    }

}
