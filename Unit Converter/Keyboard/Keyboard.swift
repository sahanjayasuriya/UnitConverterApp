//
//  Keyboard.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/30/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class {
    func actTextField() -> UITextField
    func allowNegative() -> Bool
}

class Keyboard: UIView {
    
    weak var delegate: KeyboardDelegate?
    // Defining ui buttons of the keyboard
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var negateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // Text field variable to assign focused text field
    var textField: UITextField!
    // Boolean variable to get whether negative numbers are allowed
    var allowNegative: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        // Making keyboard buttons have rounded corners
        oneButton.layer.cornerRadius = 7
        twoButton.layer.cornerRadius = 7
        threeButton.layer.cornerRadius = 7
        fourButton.layer.cornerRadius = 7
        fiveButton.layer.cornerRadius = 7
        sixButton.layer.cornerRadius = 7
        sevenButton.layer.cornerRadius = 7
        eightButton.layer.cornerRadius = 7
        nineButton.layer.cornerRadius = 7
        zeroButton.layer.cornerRadius = 7
        decimalButton.layer.cornerRadius = 7
        negateButton.layer.cornerRadius = 7
        deleteButton.layer.cornerRadius = 7
    }
    
    // Function to call when a key is tapped
    @IBAction func keyTapped(_ sender: UIButton) {
        // Assigning focused text field
        self.textField = self.delegate?.actTextField()
        // Assigning whether negative values are permitted
        self.allowNegative = self.delegate?.allowNegative()
        
        /** Tags from 0 to 9 are for numbers
            Therefore inserting tag to textfield if tag is below or equal to 9
         
            Tag 10 = Decimal point
            Tag 11 = Negate button
            Tag 12 = Clear button
         
            Doing necessory functions if tag is above 9
         */
        if(sender.tag <= 9) {
            self.textField.insertText(String(sender.tag))
        } else if(sender.tag == 10) {
            // Adding a decimal point if none exists
            if(!(self.textField.text?.contains("."))!) {
                self.textField.insertText(".")
            }
        } else if(sender.tag == 11) {
            // Negating the number if negation is allowed
            if(self.allowNegative) {
                if let number = Double(textField.text!) {
                    // Negating if a positive number
                    if(number > 0) {
                        self.textField.text = String(0 - number)
                        self.negateButton.setTitle("+", for: .normal)
                    } else {
                        self.textField.text = String(number * (-1))
                        self.negateButton.setTitle("-", for: .normal)
                    }
                }
            }
        } else if(sender.tag == 12) {
            // Removing last character
            if(textField.text?.count != 0) {
                if let text = textField.text {
                    self.textField.text = String(text.dropLast())
                    self.textField.sendActions(for: .editingChanged)
                }
            }
        }
    }
    
}
