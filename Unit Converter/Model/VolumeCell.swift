//
//  VolumeCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class VolumeCell: UITableViewCell {

    @IBOutlet weak var gallon: UILabel!
    @IBOutlet weak var litre: UILabel!
    @IBOutlet weak var ukPint: UILabel!
    @IBOutlet weak var fluidOunce: UILabel!
    @IBOutlet weak var mililitre: UILabel!
    
    func setVolume(volume: Volume) {
        gallon.text = String(volume.gallon)
        litre.text = String(volume.litre)
        ukPint.text = String(volume.pint)
        fluidOunce.text = String(volume.ounce)
        mililitre.text = String(volume.mililitre)
    }
}
