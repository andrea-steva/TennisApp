//
//  TNUser.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNUser: Object {

    //MARK: Stored Attributes
    
    dynamic var userId: String!
    dynamic var firstName: String!
    dynamic var lastName: String!
    dynamic var age: Int = 0
    dynamic var email: String!
    dynamic var phoneNumber: String!
    dynamic var profileImage: Data!

    dynamic var handType: String!
    dynamic var backhandType: String!

    dynamic var ranking: String!
    
    //MARK: Relationship
    
    var rackets = List<TNRacket>()
    var activities = List<TNActivity>()
    
    //MARK:  Primary Key

    override static func primaryKey() -> String? {
        return "userId"
    }
    
    //MARK: Init
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        userId = dictionary["userId"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    //MARK: Class Methods

}
