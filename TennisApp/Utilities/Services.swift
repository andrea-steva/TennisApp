//
//  Services.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

class Services {
    
    // MARK: Shared instance and framework initialization
    
    /** The shared instance */
    private static var instance : Services!
    
    /** Get the shared instance. */
    static func sharedInstance() -> Services {
        return instance
    }
    
    class func initialize() {
        instance = Services()
    }
    
    // MARK: Properties
    let realm : RealmDao
    
    // MARK: Init

    init() {
        self.realm = RealmDao()
    }
    
}