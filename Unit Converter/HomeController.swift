
//
//  HomeController.swift
//  Unit Converter
//
//  Created by Sahan Jayasuriya on 3/23/19.
//  Copyright © 2019 Sahan Jayasuriya. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItems = initializeMenuItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Unit Converter"
    }
    
    func initializeMenuItems() -> [MenuItem] {
        var menuItems: [MenuItem] = []
        
        let menuItem1 = MenuItem(id: "weightView", title: "Weight Conversion", image: UIImage(named: "icon-weight")!)
        let menuItem2 = MenuItem(id: "temperatureView", title: "Temperature Conversion", image: UIImage(named: "icon-temperature")!)
        let menuItem3 = MenuItem(id: "lengthView", title: "Length Conversion", image: UIImage(named: "icon-length")!)
        let menuItem4 = MenuItem(id: "speedView", title: "Speed Conversion", image: UIImage(named: "icon-speed")!)
        let menuItem5 = MenuItem(id: "volumeView", title: "Volume Conversion", image: UIImage(named: "icon-volume")!)
        
        menuItems.append(menuItem1)
        menuItems.append(menuItem2)
        menuItems.append(menuItem3)
        menuItems.append(menuItem4)
        menuItems.append(menuItem5)
        
        return menuItems
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = menuItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        
        cell.setMenuItem(menuItem: menuItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowId = menuItems[indexPath.row].id
        performSegue(withIdentifier: rowId, sender: nil)
    }
    
}
