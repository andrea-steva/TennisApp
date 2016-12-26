//
//  Racket.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Racket: Object {
    
    // MARK:  Stored Attributes
    
    dynamic var racketId : String!
    dynamic var manufacter : String!
    dynamic var model : String!
    dynamic var weight : String!
    dynamic var gripSize : String!  //from 0 to 4
    dynamic var image : Data?
    dynamic var purchaseDate : Date?
    
    // MARK: Relationship
    
    let user = LinkingObjects(fromType: User.self, property: "rackets")
    var strings = List<Strings>()
        
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "racketId"
    }
    
    // MARK: Init
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    // MARK: Class Methods

}
