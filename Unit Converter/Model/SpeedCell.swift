//
//  SpeedCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class SpeedCell: UITableViewCell {

    @IBOutlet weak var mps: UILabel!
    @IBOutlet weak var kmph: UILabel!
    @IBOutlet weak var mph: UILabel!
    @IBOutlet weak var nmph: UILabel!
    
    func setSpeed(speed: Speed) {
        mps.text = String(speed.mps)
        kmph.text = String(speed.kmph)
        mph.text = String(speed.mph)
        nmph.text = String(speed.nmph)
    }
}
