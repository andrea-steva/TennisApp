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

    @Persisted var activityId: String!
    @Persisted var title: String!
    @Persisted var notes: String = ""
    @Persisted var date: Date!
    @Persisted var place: String = ""
    @Persisted var timeSpent: Float = 0

    @Persisted var playerNameA: String!
    @Persisted var playerNameAB: String!
    var matchType: MatchType = .single

    // MARK: Relationship

    let user = LinkingObjects(fromType: User.self, property: "matches")
    var scores = List<MatchScore>()

    // MARK: Init

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
