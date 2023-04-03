//
//  Settings.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation

final class Settings: NSObject {

    fileprivate let userDefaults = UserDefaults.standard

    func deleteAll() {
        let settings = Settings()
        settings.firstLaunch = nil
    }
    
    var realmKey: Data {
        if let key = Settings().get("RealmKey") {
            return key as! Data
        }
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
        self.set("RealmKey", value: keyData)
        return keyData as Data
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

    fileprivate func get(_ key: String) -> AnyObject? {
        return userDefaults.value(forKey: key) as AnyObject?

    }

    fileprivate func set(_ key: String, value: AnyObject?) {
        if value != nil {
            userDefaults.setValue(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }

    fileprivate func getArray(_ key: String) -> [AnyObject]? {
        if let data: AnyObject = userDefaults.object(forKey: key) as AnyObject? {
            if let data: AnyObject = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as AnyObject? {
                return data as? [AnyObject]
            }
        }
        return []
    }

    fileprivate func setArray(_ key: String, value: [AnyObject]?) {
        var arrayToSave: [AnyObject]
        if let value = value {
            arrayToSave = value
        } else {
            arrayToSave = [AnyObject]()
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: arrayToSave)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }

}
