
//
//  WeightViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class WeightViewController: UITableViewController, KeyboardDelegate, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var kilogramTextField: UITextField!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var ouncesTextField: UITextField!
    @IBOutlet weak var poundsTextField: UITextField!
    @IBOutlet weak var stonePoundsTextField: UITextField!
    var activeTextField: UITextField!
    
    let kilogramConstant: Double = 1000
    let ounceConstant: Double = 28.34952
    let poundConstant: Double = 453.59237
    let stonePoundConstant: Double = 14
    
    var gramValue: Double = 0
    
    var weights = [Weight]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        keyboardView.delegate = self
        kilogramTextField.inputView = keyboardView
        gramTextField.inputView = keyboardView
        ouncesTextField.inputView = keyboardView
        poundsTextField.inputView = keyboardView
        stonePoundsTextField.inputView = keyboardView
        
        kilogramTextField.delegate = self
        gramTextField.delegate = self
        ouncesTextField.delegate = self
        poundsTextField.delegate = self
        stonePoundsTextField.delegate = self
    }
    
    func actTextField() -> UITextField{
        return activeTextField
    }
    
    func allowNegative() -> Bool{
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    @IBAction func kilogramTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToGrams(type: WeightType.KILOGRAM, value: value)
            convertAndSetWeights()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func gramTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToGrams(type: WeightType.GRAM, value: value)
            convertAndSetWeights()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func ounceTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToGrams(type: WeightType.OUNCE, value: value)
            convertAndSetWeights()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func poundTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToGrams(type: WeightType.POUND, value: value)
            convertAndSetWeights()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func stonepoundTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToGrams(type: WeightType.STONEPOUND, value: value)
            convertAndSetWeights()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    func convertToGrams(type: WeightType, value: Double) {
        if(WeightType.KILOGRAM == type) {
            gramValue = value * kilogramConstant
        } else if(WeightType.GRAM == type) {
            gramValue = value
        } else if(WeightType.OUNCE == type) {
            gramValue = value * ounceConstant
        } else if(WeightType.POUND == type) {
            gramValue = value * poundConstant
        } else if(WeightType.STONEPOUND == type) {
            gramValue = value * stonePoundConstant * poundConstant
        } else {
            gramValue = 0
        }
    }
    
    func convertAndSetWeights() {
        kilogramTextField.text = String(format: "%.4f", gramValue / kilogramConstant)
        gramTextField.text = String(format: "%.4f", gramValue)
        ouncesTextField.text = String(format: "%.4f", gramValue / ounceConstant)
        poundsTextField.text = String(format: "%.4f", gramValue / poundConstant)
        stonePoundsTextField.text = String(format: "%.4f", gramValue / (poundConstant * stonePoundConstant))
    }
    
    func setEmpty() {
        kilogramTextField.text = nil
        gramTextField.text = nil
        ouncesTextField.text = nil
        poundsTextField.text = nil
        stonePoundsTextField.text = nil
    }
    
    @IBAction func saveConversion(_ sender: UIBarButtonItem) {
        
        if(isSpaceFull()) {
            deleteFirstElement()
        }
        
        let kilogram = kilogramTextField.text
        let gram = gramTextField.text
        let ounce = ouncesTextField.text
        let pounds = poundsTextField.text
        let stonePound = stonePoundsTextField.text
        
        if let kilogramValue = Double(kilogram!),  let gramValue = Double(gram!),  let ounceValue = Double(ounce!),  let poundValue = Double(pounds!),  let stonePoundValue = Double(stonePound!){
            
            let weight = Weight(context: context)
            weight.kilogram = kilogramValue
            weight.gram = gramValue
            weight.ounce = ounceValue
            weight.pound = poundValue
            weight.stonePound = stonePoundValue
            
            do {
                try context.save()
                ProgressHUD.showSuccess("Conversion Saved")
            } catch {
                print("Error saving weight \(error)")
                ProgressHUD.showError("Saving Failed")
            }
        } else {
            ProgressHUD.showError("Amounts Cannot be Empty")
        }
    }
    
    func isSpaceFull() -> Bool {
        let request: NSFetchRequest<Weight> = Weight.fetchRequest()
        do {
            weights = try context.fetch(request)
            return weights.count >= 5
        } catch {
            print("Error fetching weight \(error)")
            return false
        }
    }
    
    func deleteFirstElement() {
        context.delete(weights[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyView = segue.destination as? HistoryViewController
        historyView?.conversionType = ConversionType.WEIGHT
    }
}

enum WeightType {
    case KILOGRAM
    case GRAM
    case OUNCE
    case POUND
    case STONEPOUND
}
