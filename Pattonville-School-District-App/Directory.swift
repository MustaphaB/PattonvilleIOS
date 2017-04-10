//
//  Directory.swift
//  Pattonville School District App
//
//  Created by Kevin Bowers on 12/12/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit

/// Singleton class to read from the CSV directory file, create staff members, and create and populate a directoryDictionary
class Directory {
    
    /// Directory to be accessed in the StaffListViewController
    static var directoryDictionary = [String:[StaffMember]]()
    
    var studentDirectoryCSVContents = ""
    
    /// Reads data from file and populates the directory Dictionary
    init() {
        
        createStaffMembers()
    }
    
    /// Reads and returns the contents of the directory CSV file
    ///
    /// - Parameter file: Name of the directory CSV file
    /// - Returns: String value of the directory CSV file
        func readDataFromURL(url: String)-> String!{
            guard let filepath = NSURL(string: url)
                else {
                    return nil
            }
            do {
                return try String(contentsOf: filepath as URL, encoding: String.Encoding.utf8)
            } catch {
                print("File Read Error for file \(filepath)")
                return nil
            }
        }

    /// Creates objects of type StaffMember from each line of the directory CSV file
    func createStaffMembers() {
        
        
        
        let mostRecentSave: Date
        
        // Get most recent save Date()
        if let recent = UserDefaults.standard.object(forKey: "lastDirectoryUpdate") as! Date?{
            mostRecentSave = recent
        }else{
            mostRecentSave = Date()
        }
        
        var dateComponent = DateComponents()
        dateComponent.year = -1
        
        // Find the date for one year ago
        let lastYear = NSCalendar(calendarIdentifier: .gregorian)?.date(byAdding: dateComponent, to: Date(), options: [])
        
        if NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path!) as? [String:[StaffMember]] != nil {
            
        }
        
        //If the most recent save time is longer than one year ago OR the object in the archived space is nil
        if mostRecentSave < lastYear! || NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path!) as? [String:[StaffMember]] != nil{
            
            Directory.directoryDictionary = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path!) as! [String : [StaffMember]]
            print("getting from saved")
            
        } else {
        
            let input = readDataFromURL(url: "https://forms.psdr3.org/psdapp/directory.csv")
            
            // Separates each line of the directory CSV file
            var lines: [String] = input!.components(separatedBy: "\n")
            
            // Removes the first line which is the name of each category for a StaffMember
            lines.removeFirst()
            
            // Creates a new StaffMember from each non-empty line of the data
            for line in lines{
                if line.characters.count > 0{
                    let staffParams: [String] = line.components(separatedBy: ",")
                    let staffMember = StaffMember(values: staffParams)
                    
                    // Changes first and last names to have first letter of the name capitalized and all other letters lowercased
                    staffMember.fName = staffMember.fName.capitalized(with: NSLocale.current)
                    staffMember.lName = staffMember.lName.capitalized(with: NSLocale.current)
                    
                    // Adds a new key, specifying location, to the directoryDictionary if one is not present
                    if(Directory.directoryDictionary.index(forKey: staffMember.directoryKey) == nil){
                        Directory.directoryDictionary[staffMember.directoryKey] = []
                    }
                    
                    // Adds the newly made StaffMember to its respective StaffMember array based on location
                    Directory.directoryDictionary[staffMember.directoryKey]?.append(staffMember)
                    
                }
            }
        
            saveToFile()
        
        }
        
    }
    
    /// Sorts all staff members by their rank
    ///
    /// - Parameters:
    ///   - first: StaffMember to be compared to second
    ///   - second: StaffMember to be compared to first
    /// - Returns: Bool value: true if first and second are in correct order, false if first and second need to switch in the order
    static func sortStaffMembers(first: StaffMember, second: StaffMember) -> Bool{
        
        // Nested if statements to check rank, then location, then alphabetical placement
        if first.rank == second.rank{
            if first.long_desc == second.long_desc{
                if first.lName == second.lName{
                    return first.fName.compare(second.fName).rawValue < 0
                }else{
                    return first.lName.compare(second.lName).rawValue < 0
                }
            }else{
                return first.long_desc.compare(second.long_desc).rawValue < 0
            }
        }else{
            return first.rank < second.rank
        }
    }
    
    // The URL of the cache file
    let fileURL: NSURL = {
        let directories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let document = directories.first!
        
        return document.appendingPathComponent("staffMember.archive") as NSURL
        
    }()
    
    /// Save directoryDictionary to the Cache File
    /// - returns: if saving succeeded
    func saveToFile(){
        NSKeyedArchiver.archiveRootObject(Directory.directoryDictionary, toFile: fileURL.path!)
        
    }
    
}











