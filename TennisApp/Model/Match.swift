//
//  Match.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Match: Object, ActivityProtocol, MatchProtocol {

    // MARK: Stored Attributes

    var activityId: String!
    var title: String!
    var notes: String = ""
    var date: Date!
    var place: String = ""
    var timeSpent: Float = 0

    var playerNameA: String!
    var playerNameAB: String!
    var matchType: MatchType = .single

    // MARK: Relationship

    let user = LinkingObjects(fromType: TUser.self, property: "matches")
    var scores = List<MatchScore>()

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

    func isMatchWon() -> Bool {

        var countGamePlayerA = 0
        var countGamePlayerB = 0
        for score in self.scores {
            countGamePlayerA += score.gamePlayerA
            countGamePlayerB += score.gamePlayerB
        }
        if countGamePlayerA > countGamePlayerB {
            return true
        }
        return false
    }
}
