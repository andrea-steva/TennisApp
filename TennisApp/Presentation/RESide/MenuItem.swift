//
//  MenuItem.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

enum MenuItem: Int {

    case activities = 0
    case rackets = 1
    case stats = 2
    case profile = 3
    case settings = 4
    case logout = 5

    static var count: Int { return MenuItem.logout.rawValue + 1 }

    func storyboardName() -> String {
        switch self {
        case .activities:
            return "Activities"
        case .rackets:
            return "Rackets"
        case .stats:
            return "Stats"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        default:
            return ""
        }
    }

    func localizedName() -> String {
        switch self {
        case .activities:
            return localizer.get(LocalizedString.menu_home)
        case .rackets:
            return localizer.get(LocalizedString.menu_rackets)
        case .stats:
            return localizer.get(LocalizedString.menu_stats)
        case .profile:
            return localizer.get(LocalizedString.menu_profile)
        case .settings:
            return localizer.get(LocalizedString.menu_settings)
        case .logout:
            return localizer.get(LocalizedString.menu_logout)
        }
    }

    func menuIcon() -> UIImage {

        let size = CGSize(width: 35, height: 35)
        let color = Style.Colors.lightColor.withAlphaComponent(0.8)

        switch self {
        case .activities:
            return UIImage.fontAwesomeIcon(name: .home, style: .regular, textColor: color, size: size)
        case .rackets:
            return UIImage.fontAwesomeIcon(name: .wrench, style: .regular, textColor: color, size: size)
        case .stats:
            return UIImage.fontAwesomeIcon(name: .chartBar, style: .regular, textColor: color, size: size)
        case .profile:
            return UIImage.fontAwesomeIcon(name: .user, style: .regular, textColor: color, size: size)
        case .settings:
            return UIImage.fontAwesomeIcon(name: .slidersH, style: .regular, textColor: color, size: size)
        case .logout:
            return UIImage.fontAwesomeIcon(name: .signOutAlt, style: .regular, textColor: color, size: size)
        }

    }
}
