//
//  Memory.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 5/2/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Memory: NSManagedObject {

    func setMemoryImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.imageMemory = data
    }
    
    func setMemoryWeatherImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.imageWeather = data
    }
    
    func setMemoryTitle(title: String) {
        self.title = title
    }
    
    func setMemoryDate(_date: NSDate) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        self.date = dateFormatter.stringFromDate(_date)
    }
    
    func setMemoryDescriptionTextField(description: String) {
        self.descriptionTextField = description
    }
    
    func setMemoryTemperature(temp: NSNumber) {
        self.temperature = temp as Double
    }
    
    func setMemoryLatitude(lat: NSNumber) {
        self.latitude = lat as Double
    }
    
    func setMemoryLongitude(lon: NSNumber) {
        self.longitude = lon as Double
    }
    
    func getMemoryImage() -> UIImage {
        let img = UIImage(data: self.imageMemory!)!
        return img
    }
    
    func getMemoryWeatherImage() -> UIImage {
        let img = UIImage(data: self.imageWeather!)!
        return img
    }
    
    func getMemoryTitle() -> String {
        return title!
    }
    
    func getMemoryDate() -> String {
        return date!
    }
    
    func getMemoryDescriptionTextField() -> String {
        return descriptionTextField!
    }
    
    func getMemoryTemperature() -> NSNumber {
        return temperature as! Double
    }
    
    func getMemoryLatitude() -> NSNumber {
        return latitude as! Double
    }
    
    func getMemoryLongitude() -> NSNumber {
        return longitude as! Double
    }
}
