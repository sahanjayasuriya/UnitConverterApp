//
//  MenuCell.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/23/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuImageView: UIImageView!
    
    func setMenuItem(menuItem: MenuItem) {
        menuTitleLabel.text = menuItem.title
        menuImageView.image = menuItem.image
    }
    
}
