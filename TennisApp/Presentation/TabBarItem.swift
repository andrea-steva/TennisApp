//
//  TabBarItem.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum TabBarItem: CaseIterable {
    case activities
    case rackets
    case stats
    case profile
    case settings

    var title: String {
        switch self {
        case .activities:
            return LocalizationKeys.menuHome
        case .rackets:
            return LocalizationKeys.menuRackets
        case .stats:
            return LocalizationKeys.menuStats
        case .profile:
            return LocalizationKeys.menuProfile
        case .settings:
            return LocalizationKeys.menuSettings
        }
    }

    var iconName: String {
        switch self {
        case .activities:
            return "house"
        case .rackets:
            return "gear"
        case .stats:
            return "chart.bar.fill"
        case .profile:
            return "person"
        case .settings:
            return "slider.horizontal.3"
        }
    }
}
