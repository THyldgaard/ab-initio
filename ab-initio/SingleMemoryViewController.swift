//
//  SingleMemoryViewController.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class SingleMemoryViewController: UIViewController {
    
    var memoryCellData: Memory?
    
    @IBOutlet weak var imageMemory: UIImageView!
    @IBOutlet weak var locationMemory: UILabel!
    @IBOutlet weak var titleMemory: UILabel!
    @IBOutlet weak var dateMemory: UILabel!
    @IBOutlet weak var descriptionMemory: UILabel!
    @IBOutlet weak var weatherMemory: UIImageView!
    @IBOutlet weak var temperatureMemory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureView() {
        guard let cellData = memoryCellData else { return }
        self.titleMemory.text = cellData.getMemoryTitle()
        self.imageMemory.image = cellData.getMemoryImage()
        self.locationMemory.text = "location: \(cellData.getMemoryLatitude()), \(cellData.getMemoryLongitude())"
        self.dateMemory.text = "Date: \(cellData.getMemoryDate())"
        self.descriptionMemory.text = cellData.getMemoryDescriptionTextField()
        self.weatherMemory.image = cellData.getMemoryWeatherImage()
        self.temperatureMemory.text = "\(cellData.getMemoryTemperature())˚C"
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
