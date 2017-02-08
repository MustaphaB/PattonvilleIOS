//
//  DateCell.swift
//  Pattonville School District App
//
//  Created by Developer on 11/8/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell{
    
    var event: Event!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var schools: UILabel!
    @IBOutlet var pinButton: UIButton!
    
    @IBOutlet var schoolColorLine: UIView!
    
    @IBAction func setPinned(){
        
        pinButton.isSelected = !pinButton.isSelected
        
        if event.pinned{
            event.setUnpinned()
        }else{
            event.setPinned()
        }

    }
    
    func setup(event: Event, indexPath: IndexPath, type: SetupType){
        
        if type == .normal{
            setupNormally(event: event, indexPath: indexPath)
        }else{
            setupEmpty()
        }
        
    }
    
    func setupEmpty(){
        
        title.text = ""
        location.text = ""
        
        startTime.text = ""
        endTime.text = ""
        pinButton.isHidden = true
        
        schoolColorLine.isHidden = true
        
        self.accessoryType = .none
        self.selectionStyle = .none
        
    }
    
    func setupNormally(event: Event, indexPath: IndexPath){
        
        self.event = event
        
        title.text = event.name
        location.text = event.dateString
        
        if event.pinned{
            pinButton.isSelected = true
        }else{
            pinButton.isSelected = false
        }
        
        setTimes(start: event.startTime!, end: event.endTime!)

        schoolColorLine.isHidden = false
        schoolColorLine.backgroundColor = event.school?.color
        
        pinButton.isHidden = false
        pinButton.tag = indexPath.row;
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .default
        
    }
    
    private func setTimes(start: Date, end: Date){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        let startTimeString = formatter.string(from: start)
        let endTimeString = formatter.string(from: end)
        
        endTime.text = endTimeString
        startTime.text = startTimeString
        
    }
    
}


enum SetupType{
    case normal
    case empty
}
