//
//  Settings.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation

class Settings : NSObject {
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func deleteAll() {
        let settings = Settings()
        settings.firstLaunch = nil
    }
    
    //MARK: User Settings
    
    var exampleSettings: Int? {
        get {
            if let value = self.get("exampleSettings") as? Int {
                return value
            }
            return 0
        }
        
        set {
            self.set("exampleSettings", value: newValue)
        }
    }
    
    //MARK: App Settings
    
    var firstLaunch: Bool? {
        get {
            if let value = self.get("firstLaunch") as? Bool? {
                return value
            }
            return nil
        }
    
        set {
            self.set("firstLaunch", value: newValue)
        }
    }
    
    // MARK: - Get/set from user defaults
    
    private func get(key : String) -> AnyObject? {
        return userDefaults.valueForKey(key)
        
    }
    
    private func set(key : String, value : AnyObject?) {
        if value != nil {
            userDefaults.setValue(value, forKey: key)
        }
        else {
            userDefaults.removeObjectForKey(key)
        }
        userDefaults.synchronize()
    }
    
    private func getArray(key : String) -> [AnyObject]? {
        if let watchlistData : AnyObject = userDefaults.objectForKey(key) {
            if let watchlist : AnyObject = NSKeyedUnarchiver.unarchiveObjectWithData(watchlistData as! NSData) {
                return watchlist as? [AnyObject]
            }
        }
        return []
    }
    
    private func setArray(key : String, value : [AnyObject]?)  {
        var arrayToSave : [AnyObject]
        if let value = value {
            arrayToSave = value
        }
        else {
            arrayToSave = [AnyObject]()
        }
        let watchlistData = NSKeyedArchiver.archivedDataWithRootObject(arrayToSave)
        userDefaults.setObject(watchlistData, forKey: key)
        userDefaults.synchronize()
    }
    
}