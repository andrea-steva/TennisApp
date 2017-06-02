//
//  Enum.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation
import UIKit

enum RacketBrand: String {
    case babolat = "Babolat"
    case dunlop = "Dunlop"
    case head = "Head"
    case yonex = "Yonex"
    case prince = "Prince"
    case prokennex = "ProKennex"
    case tecnifibre = "Tecnifibre"
    case wilson = "Wilson"
    
    static let allValues = [babolat.rawValue,
                            dunlop.rawValue,
                            head.rawValue,
                            yonex.rawValue,
                            prince.rawValue,
                            prokennex.rawValue,
                            tecnifibre.rawValue,
                            wilson.rawValue]
}

enum GripSize: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    
    static let allValues = [one.rawValue,
                            two.rawValue,
                            three.rawValue,
                            four.rawValue,
                            five.rawValue]
}

enum MatchType: Int {
    case single
    case double
    case mixed
    case other
}

enum PracticeType: Int {
    case forehand
    case backhand
    case service
    case volley
}

enum FitnessType: Int {
    case running
    case uppperBody
    case downBody
    case other
}

// MARK: - Menu Item

enum MenuItem: Int {
    
    case activities = 0
    case rackets = 1
    case stats = 2
    case profile = 3
    case settings = 4
    case logout = 5
    
    static var count: Int { return MenuItem.logout.rawValue + 1}
    
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
        let color  = Style.Colors.lightColor.withAlphaComponent(0.8)
        
        switch self {
        case .activities:
            return UIImage.fontAwesomeIcon(name: .home, textColor: color, size: size)
        case .rackets:
            return UIImage.fontAwesomeIcon(name: .wrench, textColor: color, size: size)
        case .stats:
            return UIImage.fontAwesomeIcon(name: .barChartO, textColor: color, size: size)
        case .profile:
            return UIImage.fontAwesomeIcon(name: .user, textColor: color, size: size)
        case .settings:
            return UIImage.fontAwesomeIcon(name: .sliders, textColor: color, size: size)
        case .logout:
            return UIImage.fontAwesomeIcon(name: .signOut, textColor: color, size: size)
        }
        
    }
}
