//
//  MatchEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

final class MatchEntity: Object {

    // MARK: Stored Attributes

    @Persisted var activityId: String!
    @Persisted var title: String!
    @Persisted var notes: String = ""
    @Persisted var date: Date!
    @Persisted var place: String = ""
    @Persisted var timeSpent: Float = 0

    @Persisted var playerNameA: String!
    @Persisted var playerNameAB: String!
    var matchType: Match.MatchType = .single

    // MARK: Relationship

    let user = LinkingObjects(fromType: UserEntity.self, property: "matches")
    var scores = List<MatchScoreEntity>()
}
