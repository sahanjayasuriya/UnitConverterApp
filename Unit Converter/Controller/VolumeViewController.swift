//
//  VolumeViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class VolumeViewController: UITableViewController {

    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet weak var mililitreTextField: UITextField!
    
    let gallonConstant: Double = 0.219969
    let pintConstant: Double = 1.759754
    let ounceConstant: Double = 35.195080
    let mililitreConstant: Double = 1000
    
    var litreValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

enum VolumeType {
    case LITRE
    case GALLON
    case PINT
    case OUNCE
    case MILILITRE
}
