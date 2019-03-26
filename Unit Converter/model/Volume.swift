//
//  Volume.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/26/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation

class Volume {
    var gallon: Double
    var litre: Double
    var pint: Double
    var ounce: Double
    var mililitre: Double
    
    init(gallon: Double, litre: Double, pint: Double, ounce: Double, mililitre: Double) {
        self.gallon = gallon
        self.litre = litre
        self.pint = pint
        self.ounce = ounce
        self.mililitre = mililitre
    }
}
