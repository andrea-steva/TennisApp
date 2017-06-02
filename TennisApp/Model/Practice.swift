//
//  Practice.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Practice: Object, PracticeProtocol {

    // MARK: Stored Attributes

    var activityId: String!
    var title: String!
    var notes: String = ""
    var date: Date!
    var place: String = ""
    var timeSpent: Float = 0

    var practiceType: PracticeType = .forehand

    // MARK: Relationship

    let user = LinkingObjects(fromType: User.self, property: "practices")

    // MARK: Primary Key

    override static func primaryKey() -> String? {
        return "activityId"
    }

    // MARK: Init

    required init() {
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    // MARK: Class Methods
}
