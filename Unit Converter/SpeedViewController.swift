//
//  SpeedViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/24/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class SpeedViewController: UITableViewController {

    @IBOutlet weak var mpsTextField: UITextField!
    @IBOutlet weak var kphTextField: UITextField!
    @IBOutlet weak var mphTextField: UITextField!
    @IBOutlet weak var nmphTextField: UITextField!
    
    let kphConstant: Double = 3.6
    let mphConstant: Double = 2.2369362921
    let nmphConstant: Double = 1.9438612861
    
    var mpsValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

enum SpeedType {
    case MPS
    case KMPH
    case MPH
    case NMPH
}
