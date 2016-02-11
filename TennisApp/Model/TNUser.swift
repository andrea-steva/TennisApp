//
//  TNUser.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

class TNUser: Object {

    //MARK: Stored Attributes
    
    dynamic var userId: String!
    dynamic var firstName: String!
    dynamic var lastName: String!
    dynamic var age: Int = 0
    dynamic var email: NSDate!
    dynamic var phoneNumber: String!
    dynamic var profileImage: NSData!

    dynamic var handType: String!
    dynamic var backhandType: String!

    dynamic var backhandrankingType: String!
    
    //MARK: Relationship
    
    var rackets = List<TNRacket>()
    var activities = List<TNActivity>()
    
    //MARK:  Methods
    
    required init() {
        super.init()
    }

    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        userId = dictionary["userId"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
    }
}
