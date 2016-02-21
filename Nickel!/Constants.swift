//
//  Constants.swift
//  Nickel!
//
//  Created by Andrew Palka on 2/18/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//


import UIKit
import CloudKit


let cka = CloudKitAccess()
let userDefaults = NSUserDefaults.standardUserDefaults()
let container = CKContainer.defaultContainer()
let publicDatabase = container.publicCloudDatabase
let privateDatabase = container.privateCloudDatabase
let businessID = userDefaults.stringForKey("currentBusinessUID")
let memberName = userDefaults.stringForKey("currentUserName")


var CURRENT_USER_RECORD: CKRecord?
var CURRENT_BUSINESS_RECORD: CKRecord?

func popAlertForNoText(vc: UIViewController, textFieldNotDisplayingText: UITextField) {
    let noTextAlertController: UIAlertController = UIAlertController(title: "Please enter a valid response" ,
        message: textFieldNotDisplayingText.placeholder,
        preferredStyle: .Alert)
    let noTextAlertAction: UIAlertAction = UIAlertAction(title: "Sorry, won't happen again!",
        style: UIAlertActionStyle.Cancel,
        handler: nil)
    
    noTextAlertController.addAction(noTextAlertAction)
    vc.presentViewController(noTextAlertController, animated: true, completion: nil)
    
}

func validateFieldInput (text : String, identifier: Int) -> Bool {
    var regex = String?()
    
    switch(identifier) {
    case 1:    if text.characters.count > 3 {
        return true
    } else {
        return false
        }
    case 2:     regex = "[A-Z0-9a-z._%+-]{4}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2}"
    default:
        return false
    }
    
    let range = text.rangeOfString(regex!, options: .RegularExpressionSearch)
    let result = range != nil ? true : false
    return result
}

//MARK: Custom Functions

func fetchPublicDataFromCloud(recType: String) {
    let privateDatabase = container.privateCloudDatabase
    let predicate = NSPredicate(value: true)
    
    let query = CKQuery(recordType: recType, predicate: predicate)
}

