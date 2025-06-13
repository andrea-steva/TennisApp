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

    let identifier: String
    let name: String
    let notes: String
    let place: String
    let date: Date?
    let timeSpent: Double
    let practiceType: PracticeType

    // MARK: Relationship

    let user: User?
}
