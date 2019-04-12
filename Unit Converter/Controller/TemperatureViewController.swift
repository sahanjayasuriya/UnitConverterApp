//
//  TemperatureViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class TemperatureViewController: UITableViewController, KeyboardDelegate, UITextFieldDelegate {

    // Defining text fields
    @IBOutlet weak var celciusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    // Text field variable to detect the active text field
    var activeTextField: UITextField!
    
    // Conversion constants
    let fahrenheitConstant1: Double = 32
    let fahrenheitConstant2: Double = 5/9
    let kelvinConstant: Double = 273.15
    
    // To store celcius value
    var celciusValue: Double = 0
    
    // Array to store history data
    var temperatures = [Temperature]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        celciusTextField.inputView = keyboardView
        fahrenheitTextField.inputView = keyboardView
        kelvinTextField.inputView = keyboardView
        
        celciusTextField.delegate = self
        fahrenheitTextField.delegate = self
        kelvinTextField.delegate = self
    }
    
    // Function to get active text field
    func actTextField() -> UITextField{
        return activeTextField
    }
    
    // Function to get allow negative value
    func allowNegative() -> Bool{
        return true
    }
    
    // Function to set active text field on text field begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    // Function to trigger when celcius text field changed
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
    
    // Function to trigger when fahrenheit text field changed
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
    
    // Function to trigger when kelvin text field changed
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
    
    // Function to convert from any unit to celcius
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
    
    // Function to set temperatures by converting celcius values
    func convertAndSetTemperature() {
        celciusTextField.text = String(format: "%.4f", celciusValue)
        fahrenheitTextField.text = String(format: "%.4f", (celciusValue / fahrenheitConstant2) + fahrenheitConstant1)
        kelvinTextField.text = String(format: "%.4f", celciusValue - kelvinConstant)
        
    }
    
    // Function to set text fields empty
    func setEmpty() {
        celciusTextField.text = nil
        fahrenheitTextField.text = nil
        kelvinTextField.text = nil
    }
    
    // Function to save conversion
    @IBAction func saveConversion(_ sender: UIBarButtonItem) {
        if(isSpaceFull()) {
            deleteFirstElement()
        }
        
        let celcius = celciusTextField.text
        let fahrenheit = fahrenheitTextField.text
        let kelvin = kelvinTextField.text
        
        if let celciusValue = Double(celcius!),  let fahrenheitValue = Double(fahrenheit!),  let kelvinValue = Double(kelvin!) {
            
            let temperature = Temperature(context: context)
            temperature.celcius = celciusValue
            temperature.fahrenheit = fahrenheitValue
            temperature.kelvin = kelvinValue
            
            do {
                try context.save()
                ProgressHUD.showSuccess("Conversion Saved")
            } catch {
                print("Error saving temperature \(error)")
                ProgressHUD.showError("Saving Failed")
            }
        } else {
            ProgressHUD.showError("Amounts Cannot be Empty")
        }
    }
    
    // Function to check if conversions have reached maximum storage space (5)
    func isSpaceFull() -> Bool {
        let request: NSFetchRequest<Temperature> = Temperature.fetchRequest()
        do {
            temperatures = try context.fetch(request)
            return temperatures.count >= 5
        } catch {
            print("Error fetching temperature \(error)")
            return false
        }
    }
    
    // Function to delete oldest conversion from history
    func deleteFirstElement() {
        context.delete(temperatures[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyView = segue.destination as? HistoryViewController
        historyView?.conversionType = ConversionType.TEMPERATURE
    }
}

// Temperature type enum
enum TemperatureType {
    case CELCIUS
    case FAHRENHEIT
    case KELVIN
}
