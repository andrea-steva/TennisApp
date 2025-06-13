//
//  Match.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Match {

    enum MatchType: String {
        case single
        case double
        case mixed
        case other
    }

    // MARK: Stored Attributes

    let identifier: String
    let name: String
    let notes: String
    let place: String
    let timeSpent: Double
    let date: Date?

    let playerNameA: String
    let playerNameB: String
    let matchType: MatchType

    // MARK: Relationship

    let user: User?
    let scores: [MatchScore]

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
