//
//  SymbolTokens.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol SymbolTokensProvider {
    var tabBar: TabBarSymbolNamesProvider { get }
    var settings: SettingsSymbolNamesProvider { get }
}

struct SymbolTokens: SymbolTokensProvider {
    let tabBar: TabBarSymbolNamesProvider = TabBarSymbolNames()
    let settings: SettingsSymbolNamesProvider = SettingsSymbolNames()
}

// MARK: TabBar

protocol TabBarSymbolNamesProvider {
    var activities: String { get }
    var rackets: String { get }
    var stats: String { get }
    var profile: String { get }
    var settings: String { get }
}

struct TabBarSymbolNames: TabBarSymbolNamesProvider {
    let activities = "house"
    let rackets = "gear"
    let stats = "chart.bar.fill"
    let profile = "person"
    let settings = "slider.horizontal.3"
}

// MARK: Settings

protocol SettingsSymbolNamesProvider {
    var general: String { get }
    var support: String { get }
    var review: String { get }
    var logout: String { get }
}

struct SettingsSymbolNames: SettingsSymbolNamesProvider {
    let general = "gear"
    let support = "message"
    let review = "star.square"
    let logout = "person.crop.circle.badge.xmark"
}
