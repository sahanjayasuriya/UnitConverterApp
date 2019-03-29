//
//  Temperature.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/26/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation

class Temperature {
    var celcius: Double
    var fahrenheit: Double
    var kelvin: Double
    
    init(celcius: Double, fahrenheit: Double, kelvin: Double) {
        self.celcius = celcius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
}
