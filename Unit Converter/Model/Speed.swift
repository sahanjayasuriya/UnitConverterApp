//
//  Speed.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/26/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation

class Speed {
    var mps: Double
    var kmph: Double
    var mph: Double
    var nmph: Double
    
    init(mps: Double, kmph: Double, mph: Double, nmph: Double) {
        self.mps = mps
        self.kmph = kmph
        self.mph = mph
        self.nmph = nmph
    }
}
