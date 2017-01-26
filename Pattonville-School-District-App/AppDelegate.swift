//
//  AppDelegate.swift
//  Pattonville School District App
//
//  Created by Developer on 9/27/16.
//  Copyright © 2016 Pattonville School Distrcit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let newsReel = NewsReel()
    let calendarList = Calendar()
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            NSLog("not first launch is ithis working")
            // var readingSavedIsSubcribedToBooleanValueArray: Array<Any>
            for school in SchoolsArray.allSchools{
                school.isSubscribedTo =  UserDefaults.standard.bool(forKey: school.name)
                print("\(school.name) launched with bool value \(school.isSubscribedTo)")
            }
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            //NSLog("First launch, setting UserDefault. NSLog")
            SchoolsArray.init()
        }
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navBarController = window!.rootViewController as! UITabBarController
        
        let navHomeController = navBarController.viewControllers![0] as! UINavigationController
        let homeController = navHomeController.topViewController as! PSDViewController
        
        let navNewsController = navBarController.viewControllers![1] as! UINavigationController
        let newsController = navNewsController.topViewController as! NewsViewController
        
        let navCalController = navBarController.viewControllers![2] as! UINavigationController
        let calendarController = navCalController.topViewController as! CalendarViewController
        
        
        
        homeController.newsReel = newsReel
        newsController.newsReel = newsReel
        calendarController.calendarList = calendarList
        calendarController.selectedDate = Date()
        
        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 51/255.0, alpha: 1.0)
       /* let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            NSLog("not first launch is ithis working")
           // var readingSavedIsSubcribedToBooleanValueArray: Array<Any>
            for school in SchoolsArray.allSchools{
                school.isSubscribedTo =  UserDefaults.standard.bool(forKey: school.name)
                print("\(school.name) launched with bool value \(school.isSubscribedTo)")
            }
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            //NSLog("First launch, setting UserDefault. NSLog")
            SchoolsArray.init()
        }*/
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       /* if PropertyListSerialization.propertyList(SchoolsArray.allSchools, isValidFormat: .XMLFormat_v1_0){
            do{
                let data = try PropertyListSerialization.datawithPropertyList(SchoolsArray.allSchools, format: .XMLFormat_v_1_0, options: 0)
                data.writeToUrl(url, atomically: true)
            }
            catch{
                print("Error writing plist:\(error)")
            }*/
        for school in SchoolsArray.allSchools{
            UserDefaults.standard.set(school.isSubscribedTo, forKey: school.name)
            print("\(school.name) saved with bool value \(school.isSubscribedTo)")
           // NSLog("\(school.name) saved with bool value \(school.isSubscribedTo). NSLogTAG0123")
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

