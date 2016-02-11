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
    case generic_wait = "generic.wait"
    case generic_search = "generic.search"
    case generic_confirm = "generic.confirm"
    case generic_success = "generic.success"
    case generic_error = "generic.error"
    case generic_ok = "generic.ok"
    case generic_yes = "generic.yes"
    case generic_warning = "generic.warning"
    case generic_loadMore = "generic.loadMore"
    case generic_featureNotImplemented = "generic.featureNotImplemented"
    case generic_emptyDataSetTitle = "generic.emptyDataSetTitle"
    case generic_addToCalendar = "generic.addToCalendar"
    case generic_addToWallet = "generic.addToWallet"
    case generic_showDetails = "generic.showDetails"
    case generic_cannotSendEmail = "generic.cannotSendEmail"
    case generic_notAvailable = "generic.notAvailable"
    case generic_alertTitle = "generic.alertTitle"
    
    case settings_title = "settings.title"
    case settings_walkthrough = "settings.walkthrough"
    case settings_support = "settings.support"
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
