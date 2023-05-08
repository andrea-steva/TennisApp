//
//  Activities.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum Activities: Int, CaseIterable {
    case match
    case practice
    case workout

    var title: String {
        switch self {
        case .match:
            return "Matches"
        case .practice:
            return "Practice"
        case .workout:
            return "Workout"
        }
    }
}
