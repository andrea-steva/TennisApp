//
//  MatchScoreEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//
import CoreData

    // MARK: Relationship

    // let match = LinkingObjects(fromType: MatchEntity.self, property: "scores")

extension MatchScoreEntity {

    func toDomain() -> MatchScore {
        MatchScore(setIndex: Int(self.setIndex),
                   gamePlayerA: Int(self.gamePlayerA),
                   gamePlayerB: Int(self.gamePlayerB))
    }
}

extension MatchScoreEntity {
    convenience init(match: MatchScore, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        setIndex = Int32(match.setIndex)
        gamePlayerA = Int32(match.gamePlayerA)
        gamePlayerB = Int32(match.gamePlayerB)
    }
}
