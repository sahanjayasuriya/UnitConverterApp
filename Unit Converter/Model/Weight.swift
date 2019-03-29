//
//  Weight.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/26/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation

class Weight {
    var kilogram: Double
    var gram: Double
    var ounce: Double
    var pound: Double
    var stonePound: Double
    
    init(kilogram: Double, gram: Double, ounce: Double, pound: Double, stonePound: Double) {
        self.kilogram = kilogram
        self.gram = gram
        self.ounce = ounce
        self.pound = pound
        self.stonePound = stonePound
    }
}
