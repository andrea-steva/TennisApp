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

    private var designLibrary: DesignLibraryProvider { DesignLibrary() }

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
            return designLibrary.symbol.settings.general
        case .support:
            return designLibrary.symbol.settings.support
        case .review:
            return designLibrary.symbol.settings.review
        case .logout:
            return designLibrary.symbol.settings.logout
        }
    }
}
