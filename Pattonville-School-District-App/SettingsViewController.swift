//
//  SettingsViewController.swift
//  Pattonville School District App
//
//  Created by Micah Thompkins on 11/16/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit
/// The UITableViewController that is used to display the list of application settings
class SettingsViewController: UITableViewController{
    
    @IBOutlet weak var recentNewsStepper: UIStepper!
    
    @IBOutlet weak var recentNewsCounter: UILabel!
    
    @IBAction func recentNewsChanged(_ sender: UIStepper) {
        
        let value = sender.value
        print(sender.value)
        UserDefaults.standard.set(value, forKey: "recentNews")
        recentNewsCounter.text = Int(sender.value).description
     

    }
    
    @IBOutlet weak var upcomingNewsStepper: UIStepper!
    
    @IBOutlet weak var upcomingNewsCounter: UILabel!
    
    @IBAction func upcomingNewsChanged(_ sender: UIStepper) {
        
        let value = sender.value
        UserDefaults.standard.set(value, forKey: "upcomingNews")
        upcomingNewsCounter.text = Int(sender.value).description
        
        
        
    }
   
    @IBOutlet weak var pinnedEventsStepper: UIStepper!
    
    @IBOutlet weak var pinnedEventsCounter: UILabel!
    
    @IBAction func pinnedEventsChanged(_ sender: UIStepper) {
        let value = sender.value
        UserDefaults.standard.set(value, forKey: "pinnedEvents")
        pinnedEventsCounter.text = Int(sender.value).description
        
        
        
    }
    
    var device = UIDevice()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceTypeString = device.model
        
        if(deviceTypeString == "iPad"){
            recentNewsCounter.text = UserDefaults.standard.integer(forKey: "recentNews").description
            recentNewsStepper.minimumValue = 5
            recentNewsStepper.maximumValue = 8
            recentNewsStepper.value = Double(UserDefaults.standard.integer(forKey: "recentNews"))
            upcomingNewsCounter.text = UserDefaults.standard.integer(forKey: "upcomingNews").description
            upcomingNewsStepper.minimumValue = 5
            upcomingNewsStepper.maximumValue = 8
            upcomingNewsStepper.value = Double(UserDefaults.standard.integer(forKey:"upcomingNews"))
            pinnedEventsCounter.text = UserDefaults.standard.integer(forKey: "pinnedEvents").description
            pinnedEventsStepper.minimumValue = 5
            pinnedEventsStepper.maximumValue = 8
            pinnedEventsStepper.value = Double(UserDefaults.standard.integer(forKey: "pinnedEvents"))
            
            
        } else{
            recentNewsCounter.text = UserDefaults.standard.integer(forKey: "recentNews").description
            recentNewsStepper.minimumValue = 3
            recentNewsStepper.maximumValue = 6
            recentNewsStepper.value = Double(UserDefaults.standard.integer(forKey: "recentNews"))
            upcomingNewsCounter.text = UserDefaults.standard.integer(forKey: "upcomingNews").description
            upcomingNewsStepper.minimumValue = 3
            upcomingNewsStepper.maximumValue = 6
            upcomingNewsStepper.value = Double(UserDefaults.standard.integer(forKey:"upcomingNews"))
            pinnedEventsCounter.text = UserDefaults.standard.integer(forKey: "pinnedEvents").description
            pinnedEventsStepper.minimumValue = 3
            pinnedEventsStepper.maximumValue = 6
            pinnedEventsStepper.value = Double(UserDefaults.standard.integer(forKey: "pinnedEvents"))
            
        }
        
        tableView.delegate = self
        
        tableView.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
