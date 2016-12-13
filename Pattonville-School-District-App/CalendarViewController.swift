//
//  SecondViewController.swift
//  Pattonville School District App
//
//  Created by Developer on 9/27/16.
//  Copyright © 2016 Pattonville School Distrcit. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var calendar: JTAppleCalendarView!
    @IBOutlet var tableView: UITableView!
    
    var calendarList: Calendar!
    
    var selectedDate: Date = Date()
    
    var selectedDateEvents = [Event]()
    var pinnedDateEvents = [Event]()
    
    /// Sets up look of view controller upon loading. Completes basic setup of Calendar and TableView appearances and sorts the events list for pinned events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarList.addDate(event: Event(name: "Robotics Meet", dateString: "2016-12-19", startTime: "10:00 AM", endTime: "2:00 PM", location: "PHS Cafeteria"))
        calendarList.addDate(event: Event(name: "Robotics Meet", dateString: "2016-12-19", startTime: "10:00 AM", endTime: "2:00 PM", location: "PHS Cafeteria"))
        calendarList.addDate(event: Event(name: "Robotics Meet", dateString: "2016-12-19", startTime: "10:00 AM", endTime: "2:00 PM", location: "PHS Cafeteria"))
        calendarList.addDate(event: Event(name: "Winter Orchestra Concert", dateString: "2016-12-08", startTime: "7:00 PM", endTime: "9:00 PM", location: "PHS Auditorium"))
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "DateCell", bundle: nil), forCellReuseIdentifier: "DateCell")
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        calendar.registerCellViewXib(file: "DateView")
        calendar.registerHeaderView(xibFileNames: ["CalendarHeaderView"])
        
        calendar.cellInset = CGPoint(x: 0, y: 0.25)
        
        calendar.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false)
        
        pinnedDateEvents = calendarList.datesList.filter({
            return $0.pinned
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /// Establishes appearance of view controller upon appearance on screen. Reloads calendar and tableview data and filter calendar events for teh current date.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        calendar.reloadData()
        tableView.reloadData()
        
        filterCalendarData(for: selectedDate)
        calendar.selectDates([Date(), selectedDate])
        
        print("VIEW DID APPEAR")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Sets up basic configuration for the calendar
    /// - calendar: the instance of the calendar onscreen
    /// - returns: a ConfigurationParameters object that is used by the calendar to complete intialization
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let firstDate = formatter.date(from: "2016 01 01")
        let secondDate = formatter.date(from: "2020 12 31")
        let numberOfRows = 6
        let aCalendar = NSCalendar.current
        
        return ConfigurationParameters(startDate: firstDate!,
                                       endDate: secondDate!,
                                       numberOfRows: numberOfRows,
                                       calendar: aCalendar,
                                       generateInDates: InDateCellGeneration.forAllMonths,
                                       generateOutDates: OutDateCellGeneration.tillEndOfGrid,
                                       firstDayOfWeek: DaysOfWeek.sunday)
        
    }
    
    /// Sets up a cell instance for each date on the calendar
    /// - calendar: the instance of the calendar onscreen
    /// - cell: the cell that is being setup
    /// - date: a date object associated with the cell
    /// - cellState: the state of the cell (used to determine weekday from weekend)
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState){
        
        (cell as! CalendarDateView).setupCellBeforeDisplay(cellState: cellState, date: date)
        
    }
    
    /// Sets the size of the header of the clanedar
    /// - calendar: the instance of the calendar onscreen
    /// - range: the date range associated with the particular header
    /// - month: the month associated with the header view
    /// - returns: the size of the header
    
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 75)
        
    }
    
    /// Sets up the instance of a header view for the clanedar
    /// - calendar: the instance of the clanedar onscreen
    /// - header: the header view object
    /// - range: the range of dates for which a given header is shown
    /// - identifier: teh unique identifier of the section header
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        
        let header = (header as! CalendarHeaderView)
        
        
        header.setupCellBeforeDisplay(date: range.end)
        
    }
    
    /// Defines the actions to undertake when a given cell is selected
    /// - calendar: the instance of the calendar onscreen
    /// - date: the date associated with the selected cell
    /// - cell: the cell that was selected
    /// - cellState: the state of the cell after being selected
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        if compareDates(date1: date, date2: Date()) && cellState.dateBelongsTo == .thisMonth{
            (cell as? CalendarDateView)?.setSelected(color: UIColor(red: 0/255.0, green: 122/255.0, blue: 51/255.0, alpha: 1.0))
        }else{
            (cell as? CalendarDateView)?.setSelected(color: UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1))
        }
        
        selectedDate = date
        
        filterCalendarData(for: date)
        
        tableView.reloadData()
        
    }
    
    /// Defines the actions to undertake when a given cell is deselected
    /// - calendar: the instance of the calendar onscreen
    /// - date: the date associated with the selected cell
    /// - cell: the cell that was selected
    /// - cellState: the state of the cell after being deselected
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CalendarDateView)?.setUnselected(cellState: cellState)
        
        calendar.selectDates([Date()])
    }
    

    
    
    
    /// Establishes the number of cells to show in the tableview section
    /// - tableView: the instance of the tableview onscreen
    /// - section: the section of the tableview
    /// - returns: the number of cells in a given section of the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEvents.count
    }
    
    /// Sets up the cell for a given row in the tableview
    /// - tableView: the instance of the tableview onscreen
    /// - indexPath: the indexPath for the particular cell
    /// - returns: the setup cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
        
        if selectedDateEvents.count > 0{
            let event = selectedDateEvents[indexPath.row]
            
            cell.event = event
            cell.setUp()
            cell.pinButton.tag = indexPath.row;
            cell.pinButton.addTarget(self, action: #selector(CalendarViewController.nowPinned(sender:)), for: UIControlEvents.touchUpInside);
            
        }
        
        return cell
    }
    
    /// Defines the functionality of a selected cell in the table
    /// - tableeView: the instance of teh teableview onscreen
    /// - indexPath: teh indexPath of the selected cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventDetail", sender: self)
    }
    
    /// Defines preparation steps for segues leaving this view controller
    /// - segue: the segue that was triggered
    /// - sender: teh object that triggered teh segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CalendarListViewSegue"{
            let destination = segue.destination as! CalendarListViewController
            destination.calendarList = calendarList
        }else if segue.identifier == "CalendarPinnedViewSegue"{
            let destination = segue.destination as! CalendarPinnedListViewController
            destination.eventsList = pinnedDateEvents
        }else if segue.identifier == "EventDetail"{
            let destination = segue.destination as! CalendarEventDetailController
            let event = tableView.indexPathForSelectedRow?.row
            destination.event = selectedDateEvents[event!]
        }
    }
    
    /// Filters the calendar events list for events on a specific date
    /// - date: the date to look for
    
    private func filterCalendarData(for date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let theDateString = dateFormatter.string(from: date)
        
        selectedDateEvents = calendarList.datesList.filter({
            return $0.dateString == theDateString
        })
    }
    
    /// Compares two dates to check for equality
    /// - date1: the first date to compare
    /// - date2: the date to compare to
    /// - returns: whether ot not the dates are equal
    
    private func compareDates(date1: Date, date2: Date) -> Bool{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let theDate = dateFormatter.string(from: date1)
        let today = dateFormatter.string(from: date2)
        
        if theDate.compare(today) == .orderedSame{
            return true
        }else{
            return false
        }
        
    }
    
    /// Establishes actions for when an event becomes pinned
    /// - sender: the event that was pinned
    
    func nowPinned(sender: UIView){
        let event = selectedDateEvents[sender.tag];
        
        if event.pinned && !pinnedDateEvents.contains(event){
            pinnedDateEvents.append(event)
        }else if(!event.pinned && pinnedDateEvents.contains(event)){
            pinnedDateEvents = pinnedDateEvents.filter({
                $0 != event
            })
        }
        
    }
    
}

