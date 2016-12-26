//
//  Localizer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit


enum LocalizerKey : String {
    
    case appName = "appName"
    
    case menu_home = "menu.home"
    case menu_rackets = "menu.rackets"
    case menu_stats = "menu.stats"
    case menu_profile = "menu.profile"
    case menu_settings = "menu.settings"
    
    case generic_done = "generic.done"
    case generic_cancel = "generic.cancel"
    case generic_error = "generic.error"
    case generic_ok = "generic.ok"
    case generic_yes = "generic.yes"
    case generic_emptyDataSetTitle = "generic.emptyDataSetTitle"
    case generic_notAvailable = "generic.notAvailable"
    case generic_alertTitle = "generic.alertTitle"
    
    case dialog_unableToLocalize = "dialog.unableToLocalize"
    case dialog_checkConnection = "dialog.checkConnection"
    
    case rackets_addRacket = "rackets.addRacket"
    
    case settings_section1 = "settings.section1"
    case settings_section2 = "settings.section2"
    case settings_currency = "settings.currency"
    case settings_tour = "settings.tour"
    case settings_support = "settings.support"
    case settings_website = "settings.website"
    case settings_version = "settings.version"
}

let localizer = Localizer()

/// The localizer class used to get the localized string
class Localizer {
    
    fileprivate var resources = [String : String]()
    
    init() {
    }
    
    func setResources(_ resources : [String : String]?) {
        if let resources = resources {
            self.resources = resources
        }
    }
    
    func get(_ key : LocalizerKey) -> String {
        return self.get(key.rawValue)
    }
    
    func get(_ key : String) -> String {
        if let value = resources[key] as String? {
            return value
        }
        var value = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        
        value = value.replacingOccurrences(of: "%s", with: "%@")
        for i in 0...10 {
            let pattern = String(format: "%i$s", i)
            value = value.replacingOccurrences(of: pattern, with: "%@")
        }
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return value
    }
}
