//
//  Localizer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

let localizer = Localizer()

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
    
    case settings_section1 = "settings.section1"
    case settings_section2 = "settings.section2"
    case settings_currency = "settings.currency"
    case settings_tour = "settings.tour"
    case settings_support = "settings.support"
    case settings_website = "settings.website"
    case settings_version = "settings.version"
}

class Localizer {
    
    private var resources = [String : String]()
    
    init() {
    }
    
    func setResources(resources : [String : String]?) {
        if let resources = resources {
            self.resources = resources
        }
    }
    
    func get(key : LocalizerKey) -> String {
        return self.get(key)
    }
    
    func get(key : String) -> String {
        if let value = resources[key] as String? {
            return value
        }
        var value = NSLocalizedString(key, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
        
        value = value.stringByReplacingOccurrencesOfString("%s", withString: "%@")
        
        for var i = 0; i <= 10; i++ {
            let pattern = String(format: "%i$s", i)
            value = value.stringByReplacingOccurrencesOfString(pattern, withString: "%@")
        }
        value = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return value
    }
}
