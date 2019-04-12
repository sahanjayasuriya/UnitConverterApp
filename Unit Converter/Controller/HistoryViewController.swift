//
//  HistoryViewController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/29/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    // Defining history table view
    @IBOutlet weak var historyTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Conversion type variable
    var conversionType: ConversionType = ConversionType.WEIGHT
    
    // Arrays to store conversions
    var weights: [Weight] = []
    var temperatures: [Temperature] = []
    var lengths: [Length] = []
    var speeds: [Speed] = []
    var volumes: [Volume] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(type: conversionType)
    }
    
    // Function to load data of the selected type
    func loadData(type: ConversionType) {
        switch type {
        case ConversionType.WEIGHT:
            loadWeight()
            self.title = "Weight Conversion History"
        case ConversionType.TEMPERATURE:
            loadTemperature()
            self.title = "Temperature Conversion History"
        case ConversionType.LENGTH:
            loadLength()
            self.title = "Length Conversion History"
        case ConversionType.SPEED:
            loadSpeed()
            self.title = "Speed Conversion History"
        case ConversionType.VOLUME:
            loadVolume()
            self.title = "Volume Conversion History"
        }
    }
    
    // Function to load weight history
    func loadWeight() {
        let request: NSFetchRequest<Weight> = Weight.fetchRequest()
        do {
            weights = try context.fetch(request)
        } catch {
            print("Error fetching weight \(error)")
        }
    }
    
    // Function to load temperature history
    func loadTemperature() {
        let request: NSFetchRequest<Temperature> = Temperature.fetchRequest()
        do {
            temperatures = try context.fetch(request)
        } catch {
            print("Error fetching temperatures \(error)")
        }
    }
    
    // Function to load length history
    func loadLength() {
        let request: NSFetchRequest<Length> = Length.fetchRequest()
        do {
            lengths = try context.fetch(request)
        } catch {
            print("Error fetching length \(error)")
        }
    }
    
    // Function to load speed history
    func loadSpeed() {
        let request: NSFetchRequest<Speed> = Speed.fetchRequest()
        do {
            speeds = try context.fetch(request)
        } catch {
            print("Error fetching speed \(error)")
        }
    }
    
    // Function to load volume history
    func loadVolume() {
        let request: NSFetchRequest<Volume> = Volume.fetchRequest()
        do {
            volumes = try context.fetch(request)
        } catch {
            print("Error fetching volume \(error)")
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        
        switch conversionType {
        case ConversionType.WEIGHT:
            count = weights.count
        case ConversionType.TEMPERATURE:
            count = temperatures.count
        case ConversionType.LENGTH:
            count = lengths.count
        case ConversionType.SPEED:
            count = speeds.count
        case ConversionType.VOLUME:
            count = volumes.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(conversionType == ConversionType.WEIGHT) {
            let weight = weights[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeightCell") as! WeightCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 21/255, green: 30/255, blue: 41/255, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            cell.setWeight(weight: weight)
            return cell
        } else if(conversionType == ConversionType.TEMPERATURE) {
            let temperature = temperatures[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell") as! TemperatureCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 21/255, green: 30/255, blue: 41/255, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            cell.setTemperature(temperature: temperature)
            return cell
        } else if(conversionType == ConversionType.LENGTH) {
            let length = lengths[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "LengthCell") as! LengthCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 21/255, green: 30/255, blue: 41/255, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            cell.setLength(length: length)
            return cell
        } else if(conversionType == ConversionType.SPEED) {
            let speed = speeds[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpeedCell") as! SpeedCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 21/255, green: 30/255, blue: 41/255, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            cell.setSpeed(speed: speed)
            return cell
        } else {
            let volume = volumes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "VolumeCell") as! VolumeCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 21/255, green: 30/255, blue: 41/255, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            cell.setVolume(volume: volume)
            return cell
        }
    }
}
