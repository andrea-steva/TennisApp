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
    
    @objc dynamic var userId: String!
    @objc dynamic var firstName: String!
    @objc dynamic var lastName: String!
    @objc dynamic var age: Int = 0
    @objc dynamic var email: String!
    @objc dynamic var phoneNumber: String!
    @objc dynamic var profileImage: Data!
    
    @objc dynamic var handType: String!
    @objc dynamic var backhandType: String!
    
    @objc dynamic var ranking: String!
    
    // MARK: Relationship
    
    var rackets = List<Racket>()
    var matches = List<Match>()
    var fitness = List<Fitness>()
    var practices = List<Practice>()
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    // MARK: Init
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(_ dictionary: [String: Any?]) {
        super.init()
        self.userId = UUID().uuidString
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
