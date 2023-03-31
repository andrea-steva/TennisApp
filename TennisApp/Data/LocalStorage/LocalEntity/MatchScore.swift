//
//  MatchScore.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class MatchScore: Object {

    // MARK: Stored Attributes

    @Persisted var gamePlayerA: Int = 0
    @Persisted var gamePlayerB: Int = 0

    // MARK: Relationship

    let match = LinkingObjects(fromType: Match.self, property: "scores")

    // MARK: Init
    
    convenience init(_ dictionary: [String: AnyObject]) {
        self.init()
    }

    convenience init(gamePlayerA: Int, gamePlayerB: Int) {
        self.init()
        self.gamePlayerA = gamePlayerA
        self.gamePlayerB = gamePlayerB

    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    // MARK: Class Methods

    func matchScoreToString() -> String {
        return "\(self.gamePlayerA)-\(self.gamePlayerB)"
    }

}
