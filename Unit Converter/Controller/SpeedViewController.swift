//
//  SpeedViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class SpeedViewController: UITableViewController, KeyboardDelegate, UITextFieldDelegate {

    @IBOutlet weak var mpsTextField: UITextField!
    @IBOutlet weak var kphTextField: UITextField!
    @IBOutlet weak var mphTextField: UITextField!
    @IBOutlet weak var nmphTextField: UITextField!
    var activeTextField: UITextField!
    
    let kphConstant: Double = 3.6
    let mphConstant: Double = 2.2369362921
    let nmphConstant: Double = 1.9438612861
    
    var mpsValue: Double = 0
    
    var speeds = [Speed]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        keyboardView.delegate = self
        mpsTextField.inputView = keyboardView
        kphTextField.inputView = keyboardView
        mphTextField.inputView = keyboardView
        nmphTextField.inputView = keyboardView
        
        mpsTextField.delegate = self
        kphTextField.delegate = self
        mphTextField.delegate = self
        nmphTextField.delegate = self
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

    @IBAction func mpsTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToMetresPerSecond(type: SpeedType.MPS, value: value)
            convertAndSetSpeed()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func kphTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToMetresPerSecond(type: SpeedType.KMPH, value: value)
            convertAndSetSpeed()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    @IBAction func mphTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToMetresPerSecond(type: SpeedType.MPH, value: value)
            convertAndSetSpeed()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    @IBAction func nmphTextFieldDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(inputValue!) {
            convertToMetresPerSecond(type: SpeedType.NMPH, value: value)
            convertAndSetSpeed()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    func convertToMetresPerSecond(type: SpeedType, value: Double) {
        if(SpeedType.MPS == type) {
            mpsValue = value
        } else if(SpeedType.KMPH == type) {
            mpsValue = value / kphConstant
        } else if(SpeedType.MPH == type) {
            mpsValue = value / mphConstant
        } else if(SpeedType.NMPH == type) {
            mpsValue = value / nmphConstant
        } else {
            mpsValue = 0
        }
    }
    
    func convertAndSetSpeed() {
        mpsTextField.text = String(format: "%.4f", mpsValue)
        kphTextField.text = String(format: "%.4f", mpsValue * kphConstant)
        mphTextField.text = String(format: "%.4f", mpsValue * mphConstant)
        nmphTextField.text = String(format: "%.4f", mpsValue * nmphConstant)
        
    }
    
    func setEmpty() {
        mpsTextField.text = nil
        kphTextField.text = nil
        mphTextField.text = nil
        nmphTextField.text = nil
    }
    
    @IBAction func saveConversion(_ sender: UIBarButtonItem) {
        if(isSpaceFull()) {
            deleteFirstElement()
        }
        
        let mps = mpsTextField.text
        let kmph = kphTextField.text
        let mph = mpsTextField.text
        let nmph = nmphTextField.text
        
        if let mpsValue = Double(mps!),  let kmphValue = Double(kmph!),  let mphValue = Double(mph!),  let nmphValue = Double(nmph!){
            
            let speed = Speed(context: context)
            speed.mps = mpsValue
            speed.kmph = kmphValue
            speed.mph = mphValue
            speed.nmph = nmphValue
            
            do {
                try context.save()
                ProgressHUD.showSuccess("Conversion Saved")
            } catch {
                print("Error saving speed \(error)")
                ProgressHUD.showError("Saving Failed")
            }
        } else {
            ProgressHUD.showError("Amounts Cannot be Empty")
        }
    }
    
    func isSpaceFull() -> Bool {
        let request: NSFetchRequest<Speed> = Speed.fetchRequest()
        do {
            speeds = try context.fetch(request)
            return speeds.count >= 5
        } catch {
            print("Error fetching speed \(error)")
            return false
        }
    }
    
    func deleteFirstElement() {
        context.delete(speeds[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyView = segue.destination as? HistoryViewController
        historyView?.conversionType = ConversionType.SPEED
    }
}

enum SpeedType {
    case MPS
    case KMPH
    case MPH
    case NMPH
}
