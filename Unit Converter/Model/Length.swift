//
//  Length.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/26/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation

class Length {
    var metre: Double
    var mile: Double
    var centimetre: Double
    var milimetre: Double
    var yard: Double
    var inch: Double
    
    init(metre: Double, mile: Double, centimetre: Double, milimetre: Double, yard: Double, inch: Double) {
        self.metre = metre
        self.mile = mile
        self.centimetre = centimetre
        self.milimetre = milimetre
        self.yard = yard
        self.inch = inch
    }
}
