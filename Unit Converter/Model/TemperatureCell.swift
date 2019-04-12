//
//  TemperatureCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class TemperatureCell: UITableViewCell {

    @IBOutlet weak var celcius: UILabel!
    @IBOutlet weak var fahrenheit: UILabel!
    @IBOutlet weak var kelvin: UILabel!
    
    func setTemperature(temperature: Temperature) {
        celcius.text = String(temperature.celcius)
        fahrenheit.text = String(temperature.fahrenheit)
        kelvin.text = String(temperature.kelvin)
    }
}
