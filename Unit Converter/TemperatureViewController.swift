//
//  TemperatureViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class TemperatureViewController: UITableViewController {

    @IBOutlet weak var celciusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    
    let fahrenheitConstant1: Double = 32
    let fahrenheitConstant2: Double = 5/9
    let kelvinConstant: Double = 273.15
    
    var celciusValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func celciusTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToCelcius(type: TemperatureType.CELCIUS, value: value)
            convertAndSetTemperature()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func fahrenheitTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToCelcius(type: TemperatureType.FAHRENHEIT, value: value)
            convertAndSetTemperature()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func kelvinTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToCelcius(type: TemperatureType.KELVIN, value: value)
            convertAndSetTemperature()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    func convertToCelcius(type: TemperatureType, value: Double) {
        if(TemperatureType.CELCIUS == type) {
            celciusValue = value
        } else if(TemperatureType.FAHRENHEIT == type) {
            celciusValue = (value - fahrenheitConstant1) * fahrenheitConstant2
        } else if(TemperatureType.KELVIN == type) {
            celciusValue = value + 273.15
        } else {
            celciusValue = 0
        }
    }
    
    func convertAndSetTemperature() {
        celciusTextField.text = String(format: "%.4f", celciusValue)
        fahrenheitTextField.text = String(format: "%.4f", (celciusValue / fahrenheitConstant2) + fahrenheitConstant1)
        kelvinTextField.text = String(format: "%.4f", celciusValue - kelvinConstant)
        
    }
    
    func setEmpty() {
        celciusTextField.text = nil
        fahrenheitTextField.text = nil
        kelvinTextField.text = nil
    }
}

enum TemperatureType {
    case CELCIUS
    case FAHRENHEIT
    case KELVIN
}
