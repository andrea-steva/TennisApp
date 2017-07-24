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

    convenience init(_ dictionary: [String: AnyObject]) {
        self.init()
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    // MARK: Class Methods
    
    func createFrom(dict: [String: Any?]) {
        self.stringId = UUID().uuidString
        self.mapping(dict)
    }
    
    func updateFrom(dict: [String: Any?]) {
        self.mapping(dict)
    }
    
    fileprivate func mapping(_ dict: [String: Any?]) {
        self.manufacter = dict["manufacter"] as! String
        self.model = dict["model"] as! String
    }
}
