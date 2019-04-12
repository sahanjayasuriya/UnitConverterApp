//
//  WeightCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class WeightCell: UITableViewCell {

    @IBOutlet weak var kilogram: UILabel!
    @IBOutlet weak var gram: UILabel!
    @IBOutlet weak var ounce: UILabel!
    @IBOutlet weak var pound: UILabel!
    @IBOutlet weak var stonePound: UILabel!
    
    func setWeight(weight: Weight) {
        kilogram.text = String(weight.kilogram)
        gram.text = String(weight.gram)
        ounce.text = String(weight.ounce)
        pound.text = String(weight.pound)
        stonePound.text = String(weight.stonePound)
    }
}
