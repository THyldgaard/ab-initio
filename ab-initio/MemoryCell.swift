//
//  MemoryCell.swift
//  ab-initio
//
//  Created by Tonni Hyldgaard on 4/13/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class MemoryCell: UITableViewCell {

    @IBOutlet weak var mainMemoryImg: UIImageView!
    @IBOutlet weak var mainMemoryCellText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(memory: Memory) {
        mainMemoryImg.image = memory.getMemoryImage()
        mainMemoryCellText.text = memory.title
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
