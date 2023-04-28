//
//  Practice.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// The practice domain object
struct Practice {

    enum PracticeType: String {
        case forehand
        case backhand
        case service
        case volley
    }

    // MARK: Stored Attributes

    var identifier: String
    var description: String
    var notes: String
    var place: String
    var date: Date?
    var timeSpent: Double
    var practiceType: PracticeType

    // MARK: Relationship

    let user: User?
}
