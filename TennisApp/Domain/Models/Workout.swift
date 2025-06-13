//
//  Workout.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Workout {

    enum WorkoutType: String {
        case running
        case uppperBody
        case downBody
        case other
    }

    // MARK: Stored Attributes

    let identifier: String
    let name: String
    let notes: String
    let place: String
    let timeSpent: Double
    let date: Date?

    let workoutType: WorkoutType

    // MARK: Relationship

    let user: User?
}
