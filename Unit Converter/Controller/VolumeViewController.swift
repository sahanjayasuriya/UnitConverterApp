//
//  VolumeViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class VolumeViewController: UITableViewController, KeyboardDelegate, UITextFieldDelegate {

    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet weak var mililitreTextField: UITextField!
    var activeTextField: UITextField!
    
    let gallonConstant: Double = 0.219969
    let pintConstant: Double = 1.759754
    let ounceConstant: Double = 35.195080
    let mililitreConstant: Double = 1000
    
    var litreValue: Double = 0
    
    var volumes = [Volume]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        keyboardView.delegate = self
        gallonTextField.inputView = keyboardView
        litreTextField.inputView = keyboardView
        pintTextField.inputView = keyboardView
        ounceTextField.inputView = keyboardView
        mililitreTextField.inputView = keyboardView
        
        gallonTextField.delegate = self
        litreTextField.delegate = self
        pintTextField.delegate = self
        ounceTextField.delegate = self
        mililitreTextField.delegate = self
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
    
    @IBAction func gallonTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToLitres(type: VolumeType.GALLON, value: value)
            convertAndSetVolumes()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    @IBAction func litreTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToLitres(type: VolumeType.LITRE, value: value)
            convertAndSetVolumes()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    @IBAction func pintTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToLitres(type: VolumeType.PINT, value: value)
            convertAndSetVolumes()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    @IBAction func ounceTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToLitres(type: VolumeType.OUNCE, value: value)
            convertAndSetVolumes()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    @IBAction func mililitreTextViewDidChange(_ sender: UITextField) {
        let inputValue = sender.text
        if let value = Double(sender.text!) {
            convertToLitres(type: VolumeType.MILILITRE, value: value)
            convertAndSetVolumes()
            sender.text = inputValue
        } else {
            setEmpty()
        }
    }
    
    func convertToLitres(type: VolumeType, value: Double) {
        if(VolumeType.GALLON == type) {
            litreValue = value / gallonConstant
        } else if(VolumeType.LITRE == type) {
            litreValue = value
        } else if(VolumeType.PINT == type) {
            litreValue = value / pintConstant
        } else if(VolumeType.OUNCE == type) {
            litreValue = value / ounceConstant
        } else if(VolumeType.MILILITRE == type) {
            litreValue = value / mililitreConstant
        } else {
            litreValue = 0
        }
    }
    
    func convertAndSetVolumes() {
        gallonTextField.text = String(format: "%.4f", litreValue * gallonConstant)
        litreTextField.text = String(format: "%.4f", litreValue)
        pintTextField.text = String(format: "%.4f", litreValue * pintConstant)
        ounceTextField.text = String(format: "%.4f", litreValue * ounceConstant)
        mililitreTextField.text = String(format: "%.4f", litreValue * mililitreConstant)
    }
    
    func setEmpty() {
        gallonTextField.text = nil
        litreTextField.text = nil
        pintTextField.text = nil
        ounceTextField.text = nil
        mililitreTextField.text = nil
    }
    
    @IBAction func saveConversion(_ sender: UIBarButtonItem) {
        if(isSpaceFull()) {
            deleteFirstElement()
        }
        
        let gallon = gallonTextField.text
        let litre = litreTextField.text
        let pint = pintTextField.text
        let ounce = ounceTextField.text
        let mililitre = mililitreTextField.text
        
        if let gallonValue = Double(gallon!),  let litreValue = Double(litre!),  let pintValue = Double(pint!),  let ounceValue = Double(ounce!),  let mililitreValue = Double(mililitre!){
            
            let volume = Volume(context: context)
            volume.gallon = gallonValue
            volume.litre = litreValue
            volume.pint = pintValue
            volume.ounce = ounceValue
            volume.mililitre = mililitreValue
            
            do {
                try context.save()
                ProgressHUD.showSuccess("Conversion Saved")
            } catch {
                print("Error saving volume \(error)")
                ProgressHUD.showError("Saving Failed")
            }
        } else {
            ProgressHUD.showError("Amounts Cannot be Empty")
        }
    }
    
    func isSpaceFull() -> Bool {
        let request: NSFetchRequest<Volume> = Volume.fetchRequest()
        do {
            volumes = try context.fetch(request)
            return volumes.count >= 5
        } catch {
            print("Error fetching volume \(error)")
            return false
        }
    }
    
    func deleteFirstElement() {
        context.delete(volumes[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyView = segue.destination as? HistoryViewController
        historyView?.conversionType = ConversionType.VOLUME
    }
}

enum VolumeType {
    case LITRE
    case GALLON
    case PINT
    case OUNCE
    case MILILITRE
}
