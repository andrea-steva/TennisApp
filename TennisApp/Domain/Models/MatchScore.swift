//
//  MatchScore.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct MatchScore {

    // MARK: Stored Attributes

    var gamePlayerA: Int = 0
    var gamePlayerB: Int = 0

    // MARK: Relationship

    let match: Match

    // MARK: Methods

    func matchScoreToString() -> String {
        "\(self.gamePlayerA)-\(self.gamePlayerB)"
    }
}
