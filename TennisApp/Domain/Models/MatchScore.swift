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

    let setIndex: Int
    let gamePlayerA: Int
    let gamePlayerB: Int

    // MARK: Relationship

//     let match: Match

    // MARK: Methods

    func matchScoreToString() -> String {
        "\(self.gamePlayerA)-\(self.gamePlayerB)"
    }
}
