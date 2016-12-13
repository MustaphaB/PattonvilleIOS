//
//  SchoolsEnum.swift
//  Pattonville School District App
//
//  Created by Kevin Bowers on 11/8/16.
//  Copyright © 2016 Pattonville School Distrcit. All rights reserved.
//

import UIKit


/// The Enum that stores all the information about the schools in School Objections, used to create the Schools array and then furhter used throughout the app through that array.
class SchoolsEnum {

static var earlyChildhood = School(name: "Early Childhood",
                            address: "11097 St. Charles Rock Rd", city: "St. Ann", state: "MO", zip: "63074",
                            mainNumber: "(314)-213-8500",
                            attendanceNumber: "N/A",
                            faxNumber: "(314)-213-8696",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=93233",
                            isSubscribedTo: false,
                            color: UIColor.red)

static var bridgewayElementary = School(name: "Bridgeway Elementary",
                            address: "11635 Oakbury Court", city: "Bridgeton", state: "MO", zip: "63044",
                            mainNumber: "(314)-213-8012",
                            attendanceNumber: "(314)-213-8112",
                            faxNumber: "(314)-213-8612",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94979",
                            isSubscribedTo: false,
                            color: UIColor.blue)

static var drummondElementary = School(name: "Drummond Elementary",
                            address: "3721 St. Bridget Lane", city: "St. Ann", state: "MO", zip: "63074",
                            mainNumber: "(314)-213-8419",
                            attendanceNumber: "(314)-213-8519",
                            faxNumber: "(314)-213-8619",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94976",
                            isSubscribedTo: false,
                            color: UIColor.black)

static var parkwoodElementary = School(name: "Parkwood Elementary",
                            address: "3199 Parkwood Lane", city: "Maryland Heights", state: "MO", zip: "63043",
                            mainNumber: "(314)-213-8015",
                            attendanceNumber: "(314)-213-8115",
                            faxNumber: "(314)-213-8615",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94967",
                            isSubscribedTo: false,
                            color: UIColor.yellow)

static var remingtonTraditional = School(name: "Remington Traditional",
                            address: "102 Fee Fee Rd", city: "Maryland Heights", state: "MO", zip: "63043",
                            mainNumber: "(314)-213-8016",
                            attendanceNumber: "(314)-213-8116",
                            faxNumber: "(314)-213-8616",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94971",
                            isSubscribedTo: false,
                            color: UIColor.magenta)

static var roseAcresElementary = School(name: "Rose Acres Elementary",
                            address: "2905 Rose Acres Lane", city: "Maryland Heights", state: "MO", zip: "63043",
                            mainNumber: "(314)-213-8017",
                            attendanceNumber: "(314)-213-8117",
                            faxNumber: "(314)-213-8617",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94970",
                            isSubscribedTo: false,
                            color: UIColor.purple)

static var willowBrookElementary = School(name: "Willow Brook Elementary",
                            address: "11022 Schuetz Road", city: "Creve Coeur", state: "MO", zip: "63146",
                            mainNumber: "(314)-213-8018",
                            attendanceNumber: "(314)-213-8118",
                            faxNumber: "(314)-213-8618",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94953",
                            isSubscribedTo: false,
                            color: UIColor.cyan)

static var holmanMiddleSchool = School(name: "Holman Middle School",
                            address: "11055 St. Charles Rock Rd", city: "St. Ann", state: "MO", zip: "63074",
                            mainNumber: "(314)-213-8032",
                            attendanceNumber: "(314)-213-8132",
                            faxNumber: "(314)-213-8632",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94975",
                            isSubscribedTo: false,
                            color: UIColor.orange)

static var heightsMiddleSchool = School(name: "Heights Middle School",
                            address: "195 Fee Fee Road", city: "Maryland Heights", state: "MO", zip: "63043",
                            mainNumber: "(314)-213-8033",
                            attendanceNumber: "(314)-213-8333",
                            faxNumber: "(314)-213-8633",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94968",
                            isSubscribedTo: false,
                            color: UIColor.gray)

static var pattonvilleHighSchool = School(name: "Pattonville High School",
                            address: "2497 Creve Coeur Mill Road", city: "Maryland Heights", state: "MO", zip: "63074",
                            mainNumber: "(314)-213-8051",
                            attendanceNumber: "(314)-213-8351",
                            faxNumber: "(314)-213-8651",
                            //schoolPicture: "",
                            peachjarURL: "https://www.peachjar.com/index.php?a=28&b=138&region=94969",
                            isSubscribedTo: false,
                            color: UIColor.green)

}

