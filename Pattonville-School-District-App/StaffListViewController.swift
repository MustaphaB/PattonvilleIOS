//
//  StaffListViewController.swift
//  Pattonville-School-District-App
//
//  Created by D3vel0per on 12/15/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit
import MessageUI

/// Controller responsible for properly displaying, emailing, and searching through staff members
class StaffListViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, MFMailComposeViewControllerDelegate {

    
    var directory = DirectoryViewController.directory
    var directoryDictionary = Directory.directoryDictionary
    var indexOfSchool: Int!
    var staffList: [StaffMember] = []
    /// Staff member array composed of staff members who match the current search
    var filteredStaffList = [StaffMember]()
    let searchController = UISearchController(searchResultsController: nil)
    var staffMember: StaffMember!
    
    /// Prepared an email with the recipient already filled in
    ///
    /// - Parameter sender: Email icon clicked to send email
    @IBAction func sendEmailButton(_ sender: UIButton) {
        searchController.searchBar.text! = ""
        searchController.dismiss(animated: false)
        if filteredStaffList.count > 0 {
            self.staffMember = filteredStaffList[sender.tag]
        } else {
            self.staffMember = staffList[sender.tag]
        }
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func callStaffMember(_ sender: UIButton) {
        
        if filteredStaffList.count > 0 {
            self.staffMember = filteredStaffList[sender.tag]
        } else {
            self.staffMember = staffList[sender.tag]
        }
        
        let schoolName = SchoolsArray.allSchools[SchoolSpecificDirectoryViewController.staticSchoolIndex].name
        
        let strPhoneNumber = "314-213-8010," + self.staffMember.ext1
        let staffName = self.staffMember.fName + " " + self.staffMember.lName
        
        if let phoneCallURL:URL = URL(string: "tel:\(strPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: schoolName, message: "Are you sure you want to call \n\(staffName)", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Call", style: .default, handler: { (action) in
                    if #available(iOS 10.0, *) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                })
                let noPressed = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
                })
                alertController.addAction(noPressed)
                alertController.addAction(yesPressed)
                present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sorts every staff member in each StaffMember array in the directory dictionary
        for school in directoryDictionary.keys{
            directoryDictionary[school] = directoryDictionary[school]?.sorted(by: Directory.sortStaffMembers)
        }
        
        staffList = directoryDictionary[SchoolsArray.allSchools[SchoolSpecificDirectoryViewController.staticSchoolIndex!].shortName]!
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.reloadData()
        
    }
    
    /// Sets the number of cells in the staff list TableView
    ///
    /// - Parameters:
    ///   - tableView: the TableView displaying StaffMember objects
    ///   - section: there is only one section
    /// - Returns: Integer value of how many cells there should be
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredStaffList.count
        } else {
            return staffList.count
        }
    }
    
    /// Assigns values to the attributes of the cell based on the staff member
    ///
    /// - Parameters:
    ///   - tableView: The TableView displaying StaffMember objects
    ///   - indexPath: The integer index for which cell is being populated
    /// - Returns: The cell with the assigned values of the staff member
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolSpecificDirectoryTableViewCell", for: indexPath) as! SchoolSpecificDirectoryTableViewCell

        let staffMember: StaffMember
        
        if searchController.isActive && searchController.searchBar.text != "" {
            staffMember = filteredStaffList[indexPath.row]
        } else {
            staffMember = staffList[indexPath.row]
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.nameLabel.text = (staffMember.fName + " " + staffMember.lName)
        cell.departmentLabel.text = staffMember.long_desc.capitalized(with: NSLocale.current)
        if(staffMember.ext1 != "") {
            cell.extButton.setTitle("x" + staffMember.ext1, for: .normal)
            cell.extButton.tag = indexPath.row
        } else {
            cell.extButton.isHidden = true
        }
        cell.emailButton.tag = indexPath.row
        
        return cell
    
    }
    
    /// Populates the filteredStaffList based on a user's search
    ///
    /// - Parameters:
    ///   - searchText: What the user typed into the search bar
    ///   - scope: What of the user input should be used (in this case all text will be used)
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredStaffList = staffList.filter{ staffMember in
            return staffMember.fName.appending(" ").appending(staffMember.lName).lowercased().contains(searchText) || staffMember.lName.appending(" ").lowercased().contains(searchText) || staffMember.long_desc.lowercased().contains(searchText)
        }
        
        tableView.reloadData()
    }
    
    /// Updates the searchController based on the filtered content
    ///
    /// - Parameter searchController: The UISearchController which manages the results of the search
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!.lowercased())
    }
    
    /// Configures a new email
    ///
    /// - Returns: The view controller that handles the user interface for the drafted email
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([self.staffMember.email])
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    /// Determines what should happen when the user is done with the email dialogue
    ///
    /// - Parameters:
    ///   - controller: View controller that handles the user interface for the drafted email
    ///   - result: What the user did with the dialogue
    ///   - error: What error was thrown by the dialogue
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
