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

    enum PracticeType: Int {
        case forehand
        case backhand
        case service
        case volley
    }
    
    // MARK: Stored Attributes

    var activityId: String
    var title: String
    var notes: String
    var date: Date
    var place: String
    var timeSpent: Float
    var practiceType: PracticeType

    // MARK: Relationship

    let user: User
}
