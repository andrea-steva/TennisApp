//
//  Fitness.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Fitness {

    enum FitnessType: Int {
        case running
        case uppperBody
        case downBody
        case other
    }

    // MARK: Stored Attributes

    var identifier: String
    var description: String
    var notes: String
    var place: String
    var timeSpent: Double
    var date: Date?

    var fitnessType: FitnessType = .running

    // MARK: Relationship

    let user: User
}
