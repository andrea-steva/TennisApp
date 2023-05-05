//
//  MatchEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

extension MatchEntity {

    func toDomain() -> Match {
        Match(identifier: self.identifier ?? "",
              name: self.name ?? "",
              notes: self.notes ?? "",
              place: self.place ?? "",
              timeSpent: self.timeSpent,
              date: self.date,
              playerNameA: self.playerA ?? "",
              playerNameB: self.playerB ?? "",
              matchType: Match.MatchType(rawValue: self.matchType ?? "") ?? .other,
              user: nil,
              scores: [])
    }
}

extension MatchEntity {
    convenience init(match: Match, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = match.identifier
        name = match.name
        notes = match.notes
        place = match.place
        timeSpent = match.timeSpent
        date = match.date
        matchType = match.matchType.rawValue
        playerA = match.playerNameA
        playerA = match.playerNameB
    }
}
