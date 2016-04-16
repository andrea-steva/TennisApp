//
//  TNString.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNString: Object {

    //MARK: Stored Attributes
    
    dynamic var stringId : String!
    dynamic var manufacter : String!
    dynamic var model : String!
    dynamic var price : String = ""
    dynamic var duration : Float = 0
    dynamic var tension : Float = 0
    
    //MARK: Relationship

    var racket: [TNRacket] {
        // Realm doesn't persist this property because it only has a getter defined
        // Define "racket" as the inverse relationship to TNRacket.strings
        return linkingObjects(TNRacket.self, forProperty: "strings")
    }
    
    //MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "stringId"
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
