//
//  MenuItem.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/23/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import Foundation
import UIKit

class MenuItem {
    var id: String
    var title: String
    var image: UIImage
    
    init(id: String, title: String, image: UIImage) {
        self.id = id
        self.title = title
        self.image = image
    }
}
