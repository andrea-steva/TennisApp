//
//  TNActivity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNActivity: Object {

    //MARK: Stored Attributes
    
    dynamic var activityId : String!
    dynamic var title : String!
    dynamic var notes : String = ""
    dynamic var date : NSDate!
    dynamic var place : String = ""
    dynamic var timeSpent : Float = 0
    
    //MARK: Relationship
    
    var user: [TNUser] {
        // Realm doesn't persist this property because it only has a getter defined
        // Define "user" as the inverse relationship to TNUser.activities
        return linkingObjects(TNUser.self, forProperty: "activities")
    }
    
    //MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "activityId"
    }
    
    //MARK: Init
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
    }
    
    //MARK: Class Methods
    
}
