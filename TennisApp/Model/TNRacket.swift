//
//  TNRacket.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNRacket: Object {
    
    //MARK:  Stored Attributes
    
    dynamic var racketId : String!
    dynamic var manufacter : String!
    dynamic var model : String!
    dynamic var weight : String!
    dynamic var gripSize : String!  //from 0 to 4
    dynamic var image : NSData?
    dynamic var purchaseDate : NSDate?
    
    //MARK: Relationship
    
    var user: [TNUser] {
        // Realm doesn't persist this property because it only has a getter defined
        // Define "user" as the inverse relationship to TNUser.rackets
        return linkingObjects(TNUser.self, forProperty: "rackets")
    }
    
    var strings = List<TNString>()
        
    //MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "racketId"
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
