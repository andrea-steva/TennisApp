//
//  Fitness.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Fitness: Object, FitnessProtocol {

    // MARK: Stored Attributes

    @objc var activityId: String!
    @objc var title: String!
    @objc var notes: String = ""
    @objc var date: Date!
    @objc var place: String = ""
    @objc var timeSpent: Float = 0

    var fitnessType: FitnessType = .running

    // MARK: Relationship

    let user = LinkingObjects(fromType: User.self, property: "fitness")

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
