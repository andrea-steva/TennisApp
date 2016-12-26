//
//  Settings.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation

class Settings : NSObject {
    
    fileprivate let userDefaults = UserDefaults.standard
    
    func deleteAll() {
        let settings = Settings()
        settings.firstLaunch = nil
    }
    
    // MARK: User Settings
    
    var exampleSettings: Int? {
        get {
            if let value = self.get("exampleSettings") as? Int {
                return value
            }
            return 0
        }
        
        set {
            self.set("exampleSettings", value: newValue as AnyObject?)
        }
    }
    
    // MARK: App Settings
    
    var firstLaunch: Bool? {
        get {
            if let value = self.get("firstLaunch") as? Bool? {
                return value
            }
            return nil
        }
    
        set {
            self.set("firstLaunch", value: newValue as AnyObject?)
        }
    }
    
    // MARK: - Get/set from user defaults
    
    fileprivate func get(_ key : String) -> AnyObject? {
        return userDefaults.value(forKey: key) as AnyObject?
        
    }
    
    fileprivate func set(_ key : String, value : AnyObject?) {
        if value != nil {
            userDefaults.setValue(value, forKey: key)
        }
        else {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }
    
    fileprivate func getArray(_ key : String) -> [AnyObject]? {
        if let watchlistData : AnyObject = userDefaults.object(forKey: key) as AnyObject? {
            if let watchlist : AnyObject = NSKeyedUnarchiver.unarchiveObject(with: watchlistData as! Data) as AnyObject? {
                return watchlist as? [AnyObject]
            }
        }
        return []
    }
    
    fileprivate func setArray(_ key : String, value : [AnyObject]?)  {
        var arrayToSave : [AnyObject]
        if let value = value {
            arrayToSave = value
        }
        else {
            arrayToSave = [AnyObject]()
        }
        let watchlistData = NSKeyedArchiver.archivedData(withRootObject: arrayToSave)
        userDefaults.set(watchlistData, forKey: key)
        userDefaults.synchronize()
    }
    
}
