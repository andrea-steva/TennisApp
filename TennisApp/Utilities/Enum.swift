//
//  Enum.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation
import UIKit

//MARK - TN Enum

enum MatchType : Int {
    case kSingle
    case kDouble
    case kMixed
    case kOther
}

enum PracticeType : Int {
    case kForehand
    case kBackhand
    case kService
    case kVolley
}

enum FitnessType : Int {
    case kRunning
    case kUpperBody
    case kDownBody
    case kOther
}

// MARK: - Menu Item

enum MenuItem : Int {
    
    case home = 0
    case rackets = 1
    case stats = 2
    case profile = 3
    case settings = 4
    
    static var count: Int { return MenuItem.settings.rawValue + 1}
    
    func storyboardName() -> String {
        switch self {
        case .home:
            return "Main"
        case .rackets:
            return "Rackets"
        case .stats:
            return "Stats"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    func localizedName() -> String {
        switch self {
        case .home:
            return localizer.get(LocalizerKey.menu_home)
        case .rackets:
            return localizer.get(LocalizerKey.menu_rackets)
        case .stats:
            return localizer.get(LocalizerKey.menu_stats)
        case .profile:
            return localizer.get(LocalizerKey.menu_profile)
        case .settings:
            return localizer.get(LocalizerKey.menu_settings)
        }
    }
    
    func menuIcon() -> UIImage {
        
        let size = CGSize(width: 35, height: 35)
        let color  = Style.Colors.lightColor.withAlphaComponent(0.8)
        
        switch self {
        case .home:
            return UIImage.fontAwesomeIcon(name: .home, textColor: color, size: size)
        case .rackets:
            return UIImage.fontAwesomeIcon(name: .rocket, textColor: color, size: size)
        case .stats:
            return UIImage.fontAwesomeIcon(name: .barChartO, textColor: color, size: size)
        case .profile:
            return UIImage.fontAwesomeIcon(name: .user, textColor: color, size: size)
        case .settings:
            return UIImage.fontAwesomeIcon(name: .cogs, textColor: color, size: size)
        }
        
    }
}
