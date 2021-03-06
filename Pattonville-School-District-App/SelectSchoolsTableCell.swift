//
//  SelectSchoolsTableCell.swift
//  Pattonville School District App
//
//  Created by Micah Thompkins on 11/30/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit

/// The custom UITableViewCell class that is used as the prototype  when generating the cells for the SelectSchoolsTableView
class SelectSchoolsTableCell: UITableViewCell{
   
    /// The UILabel that displays the School Name
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    /// The UISwitch that allows a user to toggle on and off which schools the want to see in calendar and news
    @IBOutlet weak var schoolEnabledSwitch: UISwitch!
   
    
    /// The UIView that next to schoolEnabledSwith that displays the color of the school used in calendar and maybe news(haven't decided yet) TODO
    @IBOutlet weak var schoolColorView: UIView!
    

    /// Changes the schoolColorView from a square to a circle to look more convetional in iOS
  
    /// Changes the schoolColorView from a square to a circle to look more convetional in iOS
    @IBAction func schoolEnabledSwitchValueChanged(_ sender: UISwitch) {
        //self.cellDelegate?.didChangeSwitchState(sender: self, isOn:schoolEnabledSwitch.on)
        //^^^^
    }
    /// Make the color view a circle next to the schoolEnabledSwitch
    override func layoutSubviews() {
        schoolColorView.layer.cornerRadius = schoolColorView.frame.width/2
        super.layoutSubviews()
    }
   
 
    
  
    
    
}

