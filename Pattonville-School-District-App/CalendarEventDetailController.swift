//
//  CalendarEventDetailController.swift
//  Pattonville School District App
//
//  Created by Joshua Zahner on 11/21/16.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class CalendarEventDetailController: UIViewController, EKEventEditViewDelegate{
    /*!
     @method     eventEditViewController:didCompleteWithAction:
     @abstract   Called to let delegate know the controller is done editing.
     @discussion When the user presses Cancel, presses Done, or deletes the event, this method
     is called. Your delegate is responsible for dismissing the controller. If the editing
     session is terminated programmatically using cancelEditing,
     this method will not be called.
     
     @param      controller          the controller in question
     @param      action              the action that is causing the dismissal
     */
    @available(iOS 4.0, *)
    public func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var event: Event!
    //var editViewDelegate: EKEventEditViewDelegate!
    var editViewDelegate = self
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventTime: UILabel!
    @IBOutlet var addToCalendar: UIButton!
    @IBOutlet var pinButton: UIButton!
    
    @IBAction func setPinned(){
        
        pinButton.isSelected = !pinButton.isSelected
        
        if event.pinned{
            event.setUnpinned()
        }else{
            event.setPinned()
        }
        
    }
    
    @IBAction func add(sender: UIButton){
        print("old useless method accessed")
        let alert = UIAlertController(title: "Useless", message: "old useless method accessed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    ///Sets up the look of the ViewController upon loading. Sets the eventName, eventLocation, eventDate, and eventTime UILabels to the corresponding values of the event variable.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = event.name
        
        eventName.text = event.name
        eventLocation.text = event.location
        eventDate.text = event.dateString
        eventTime.text = event.timeString
        
        if event.pinned{
            pinButton.isSelected = true
        }else{
            pinButton.isSelected = false
        }
        let rightNavigationBarAddToCalendarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector (CalendarEventDetailController.addToDeviceCalendar(_:)))
        
        
        self.navigationItem.rightBarButtonItem = rightNavigationBarAddToCalendarButton
        print(event.school?.name)
        
    }
    func addToDeviceCalendar(_ sender: UIBarButtonItem){
        print("accessed addToDeviceCalendar")
        
        let controller = EKEventEditViewController()
        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted { return }
            
            let ekEvent = EKEvent(eventStore: store)
            controller.eventStore = store;
            controller.editViewDelegate = self
            controller.event = ekEvent
            ekEvent.title = self.event.name!
            ekEvent.startDate = self.event.date!
            //ekEvent.endDate = self.event.endTime!
            if self.event.location != nil{
                ekEvent.location = self.event.location!
            }
            let status = EKEventStore.authorizationStatus(for: .event)
            switch status {
            case .authorized:
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.present(controller, animated: true, completion: nil)
                })
            case .notDetermined:
                store.requestAccess(to: .event, completion: { (granted, error) -> Void in
                    if granted == true {
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.present(controller, animated: true, completion: nil)
                        })
                    }
                })
            case .denied, .restricted:
                let alert = UIAlertController(title: "Access Denied", message: "Permission is needed to access the calendar. Go to Settings > Privacy > Calendars to allow access for the Be Collective app.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            //self.present(controller, animated: true, completion: nil)
        }
        
    }
}
