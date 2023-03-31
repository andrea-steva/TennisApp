//
//  User.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class User: Object {
    
    // MARK: Stored Attributes
    
    @Persisted(primaryKey: true) var userId: ObjectId
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var age: Int
    @Persisted var email: String = ""
    @Persisted var phoneNumber: String = ""
    @Persisted var profileImage: Data!

    @Persisted var handType: String = ""
    @Persisted var backhandType: String = ""

    @Persisted var ranking: String = ""
    
    // MARK: Relationship

    @Persisted var rackets = List<Racket>()
    @Persisted var matches = List<Match>()
    @Persisted var fitness = List<Fitness>()
    @Persisted var practices = List<Practice>()
        
    // MARK: Init
    
    required init(_ dictionary: [String: Any?]) {
        super.init()
        self.mapping(dictionary)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    // MARK: Class Methods
    
    func updateFrom(dictionary: [String: Any?]) {
        self.mapping(dictionary)
    }
    
    fileprivate func mapping(_ dictionary: [String: Any?]) {
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
    }
}
