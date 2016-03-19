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

//MARK: - Menu Item

enum MenuItem : Int {
    
    case Home = 0
    case Rackets = 1
    case Stats = 2
    case Profile = 3
    case Settings = 4
    
    static var count: Int { return MenuItem.Settings.rawValue + 1}
    
    func storyboardName() -> String {
        switch self {
        case .Home:
            return "Main"
        case .Rackets:
            return "Rackets"
        case .Stats:
            return "Stats"
        case .Profile:
            return "Profile"
        case .Settings:
            return "Settings"
        }
    }
    
    func localizedName() -> String {
        switch self {
        case .Home:
            return localizer.get(LocalizerKey.menu_home)
        case .Rackets:
            return localizer.get(LocalizerKey.menu_rackets)
        case .Stats:
            return localizer.get(LocalizerKey.menu_stats)
        case .Profile:
            return localizer.get(LocalizerKey.menu_profile)
        case .Settings:
            return localizer.get(LocalizerKey.menu_settings)
        }
    }
    
    func menuIcon() -> UIImage {
        
        let size = CGSizeMake(35, 35)
        let color  = Style.Colors.lightColor.colorWithAlphaComponent(0.8)
        
        switch self {
        case .Home:
            return UIImage.fontAwesomeIconWithName(.Home, textColor: color, size: size)
        case .Rackets:
            return UIImage.fontAwesomeIconWithName(.Rocket, textColor: color, size: size)
        case .Stats:
            return UIImage.fontAwesomeIconWithName(.BarChartO, textColor: color, size: size)
        case .Profile:
            return UIImage.fontAwesomeIconWithName(.User, textColor: color, size: size)
        case .Settings:
            return UIImage.fontAwesomeIconWithName(.Cogs, textColor: color, size: size)
        }
        
    }
}