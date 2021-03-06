//
//  SchoolsArray.swift
//  Pattonville School District App
//
//  Created by Kevin Bowers on 11/14/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit

/// SchoolsArray class to be used throughout the app to iterate over the value in the SchoolsEnum
class SchoolsArray {
    
    /// The array that belongs to SchoolsArray to be used as array that is iterated over
    static var allSchools: [School] = [SchoolsEnum.district, SchoolsEnum.pattonvilleHighSchool, SchoolsEnum.heightsMiddleSchool, SchoolsEnum.holmanMiddleSchool, SchoolsEnum.remingtonTraditional, SchoolsEnum.bridgewayElementary, SchoolsEnum.drummondElementary, SchoolsEnum.parkwoodElementary, SchoolsEnum.roseAcresElementary, SchoolsEnum.willowBrookElementary, SchoolsEnum.earlyChildhood]
    
    
    static let fileURL: NSURL = {
        let directories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let document = directories.first!
        
        return document.appendingPathComponent("schools.archive") as NSURL
        
    }()
    
    /// Function that returns the School Object associated with the name passed to the method, used in news
    ///
    /// - Parameter name: The School name string
    /// - Returns: the School that matches the name passed to it
    static func getSchoolByName(name: String) -> School{
        
        return allSchools.filter({
            $0.name.contains(name)
        }).first!
        
    }
    
    /// returns the Schools that the User is SubscribedTo which is based upon the isSubscribedTo bool set in the SelectSchoolsTableViewController
    ///
    /// - Returns: the schools that the user has subscribed to
    static func getSubscribedSchools() -> [School]{
        return allSchools.filter({
            $0.isSubscribedTo
        })
    }
    
    
    /// Gets an the array of schools objects that do not incude the District, used to populate the tableViews in More
    ///
    /// - returns: the array from Enumm with information
    static func getSchools() -> [School]{
        return allSchools.filter({
            $0 != SchoolsEnum.district
        })
    }
    
    static func saveToFile() -> Bool{
        return NSKeyedArchiver.archiveRootObject(allSchools, toFile: fileURL.path!)
    }
    
    static func readFromFile() -> Bool{
        if let archived = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path!) as? [School]{
            print("SCHOOLS FROM ARCHIVED \(fileURL.path!)")
            
            if allSchools.count < 1{
                allSchools = archived
            }
            
            return true
        }
        return false
    }
    
   
}
