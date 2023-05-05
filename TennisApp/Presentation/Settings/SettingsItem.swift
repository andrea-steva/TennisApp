//
//  SettingsItem.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum SettingsItem: Int, CaseIterable {
    case general
    case support
    case review
    case logout

    var title: String {
        switch self {
        case .general:
            return "General"
        case .support:
            return "Support"
        case .review:
            return "Write a review"
        case .logout:
            return "Logout"
        }
    }

    var iconName: String {
        switch self {
        case .general:
            return "gear"
        case .support:
            return "message"
        case .review:
            return "star.square"
        case .logout:
            return "person.crop.circle.badge.xmark"
        }
    }
}
