//
//  LengthCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class LengthCell: UITableViewCell {

    @IBOutlet weak var metre: UILabel!
    @IBOutlet weak var mile: UILabel!
    @IBOutlet weak var centimetre: UILabel!
    @IBOutlet weak var milimetre: UILabel!
    @IBOutlet weak var yard: UILabel!
    @IBOutlet weak var inch: UILabel!
    
    func setLength(length: Length) {
        metre.text = String(length.metre)
        mile.text = String(length.mile)
        centimetre.text = String(length.centimetre)
        milimetre.text = String(length.milimetre)
        yard.text = String(length.yard)
        inch.text = String(length.inch)
    }
}
