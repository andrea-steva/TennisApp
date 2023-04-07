//
//  Match.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Match {

    enum MatchType: Int {
        case single
        case double
        case mixed
        case other
    }

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

    let user: User
    var scores: [MatchScore]

    // MARK: Init

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
