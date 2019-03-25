//
//  LengthViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class LengthViewController: UITableViewController {

    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var centimetreTextField: UITextField!
    @IBOutlet weak var milimeterTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    let mileConstant: Double = 1609.344
    let centimetreConstant: Double = 100
    let milimetreConstant: Double = 1000
    let yardConstant: Double = 1.0936
    let inchConstant: Double = 0.0254
    
    var metreValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func metreTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.METRE, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func mileTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.MILE, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func centimetreTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.CENTIMETRE, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func milimetreTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.MILIMETRE, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func yardTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.YARD, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func inchTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToMetres(type: LengthType.INCH, value: value)
            convertAndSetLengths()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    func convertToMetres(type: LengthType, value: Double) {
        if(LengthType.METRE == type) {
            metreValue = value
        } else if(LengthType.MILE == type) {
            metreValue = value * mileConstant
        } else if(LengthType.CENTIMETRE == type) {
            metreValue = value / centimetreConstant
        } else if(LengthType.MILIMETRE == type) {
            metreValue = value / milimetreConstant
        } else if(LengthType.YARD == type) {
            metreValue = value / yardConstant
        } else if(LengthType.INCH == type) {
            metreValue = value * inchConstant
        } else {
            metreValue = 0
        }
    }
    
    func convertAndSetLengths() {
        metreTextField.text = String(format: "%.4f", metreValue)
        mileTextField.text = String(format: "%.4f", metreValue / mileConstant)
        centimetreTextField.text = String(format: "%.4f", metreValue * centimetreConstant)
        milimeterTextField.text = String(format: "%.4f", metreValue * milimetreConstant)
        yardTextField.text = String(format: "%.4f", metreValue * yardConstant)
        inchTextField.text = String(format: "%.4f", metreValue / inchConstant)
    }
    
    func setEmpty() {
        metreTextField.text = nil
        mileTextField.text = nil
        centimetreTextField.text = nil
        milimeterTextField.text = nil
        yardTextField.text = nil
        inchTextField.text = nil
    }
}

enum LengthType {
    case METRE
    case MILE
    case CENTIMETRE
    case MILIMETRE
    case YARD
    case INCH
}
