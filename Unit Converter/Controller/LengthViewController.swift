//
//  LengthViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class LengthViewController: UITableViewController, KeyboardDelegate, UITextFieldDelegate {

    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var centimetreTextField: UITextField!
    @IBOutlet weak var milimeterTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    var activeTextField: UITextField!
    
    let mileConstant: Double = 1609.344
    let centimetreConstant: Double = 100
    let milimetreConstant: Double = 1000
    let yardConstant: Double = 1.0936
    let inchConstant: Double = 0.0254
    
    var metreValue: Double = 0
    
    var lengths = [Length]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        keyboardView.delegate = self
        metreTextField.inputView = keyboardView
        mileTextField.inputView = keyboardView
        centimetreTextField.inputView = keyboardView
        milimeterTextField.inputView = keyboardView
        yardTextField.inputView = keyboardView
        inchTextField.inputView = keyboardView
        
        metreTextField.delegate = self
        mileTextField.delegate = self
        centimetreTextField.delegate = self
        milimeterTextField.delegate = self
        yardTextField.delegate = self
        inchTextField.delegate = self
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
    
    @IBAction func saveConversion(_ sender: UIBarButtonItem) {
        if(isSpaceFull()) {
            deleteFirstElement()
        }
        
        let metre = metreTextField.text
        let mile = mileTextField.text
        let centimetre = centimetreTextField.text
        let milimitre = milimeterTextField.text
        let yard = yardTextField.text
        let inch = inchTextField.text
        
        if let metreValue = Double(metre!),  let mileValue = Double(mile!),  let centimetreValue = Double(centimetre!),  let milimitreValue = Double(milimitre!),  let yardValue = Double(yard!),  let inchValue = Double(inch!){
            
            let length = Length(context: context)
            length.metre = metreValue
            length.mile = mileValue
            length.centimetre = centimetreValue
            length.milimetre = milimitreValue
            length.yard = yardValue
            length.inch = inchValue
            
            do {
                try context.save()
                ProgressHUD.showSuccess("Conversion Saved")
            } catch {
                print("Error saving length \(error)")
                ProgressHUD.showError("Saving Failed")
            }
        } else {
            ProgressHUD.showError("Amounts Cannot be Empty")
        }
    }
    
    func isSpaceFull() -> Bool {
        let request: NSFetchRequest<Length> = Length.fetchRequest()
        do {
            lengths = try context.fetch(request)
            return lengths.count >= 5
        } catch {
            print("Error fetching length \(error)")
            return false
        }
    }
    
    func deleteFirstElement() {
        context.delete(lengths[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyView = segue.destination as? HistoryViewController
        historyView?.conversionType = ConversionType.LENGTH
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
