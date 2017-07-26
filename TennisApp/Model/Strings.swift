//
//  Strings.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Strings: Object {

    // MARK: Stored Attributes

    dynamic var stringId: String!
    dynamic var manufacter: String!
    dynamic var model: String!
    dynamic var price: String = ""
    dynamic var gauge: String = ""
    dynamic var duration: Float = 0
    dynamic var tension: Float = 0

    // MARK: Relationship

    let racket = LinkingObjects(fromType: Racket.self, property: "strings")

    // MARK: Primary Key

    override static func primaryKey() -> String? {
        return "stringId"
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
        self.stringId = UUID().uuidString
        self.mapping(dictionary)
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    // MARK: Class Methods
    
//    func createFrom(dictionary: [String: Any?]) {
//        self.stringId = UUID().uuidString
//        self.mapping(dictionary)
//    }
    
    func updateFrom(dictionary: [String: Any?]) {
        self.mapping(dictionary)
    }
    
    fileprivate func mapping(_ dictionary: [String: Any?]) {
        self.manufacter = dictionary["manufacter"] as! String
        self.model = dictionary["model"] as! String
    }
}
