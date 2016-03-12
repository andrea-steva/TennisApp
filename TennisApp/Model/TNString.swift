//
//  TNString.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

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
    
    //MARK: Methods
    
    override static func primaryKey() -> String? {
        return "stringId"
    }
    
    required init() {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
    }
    
}
